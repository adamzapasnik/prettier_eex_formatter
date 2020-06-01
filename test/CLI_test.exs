defmodule PrettierEexFormatter.CLITest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  import CLIHelper

  test "formats multiline expression" do
    bad = """
      link "óww",
    "ew",
      Routes.some_looooooooooooooooooonger_path(@conn, :create),
            "Ewe"
    """

    assert_format bad, """
    link(
      "óww",
      "ew",
      Routes.some_looooooooooooooooooonger_path(@conn, :create),
      "Ewe"
    )
    """

    assert_format bad,
                  """
                  link(
                    "óww",
                    "ew",
                    Routes.some_looooooooooooooooooonger_path(
                      @conn,
                      :create
                    ),
                    "Ewe"
                  )
                  """,
                  line_length: 40

    assert_format bad,
                  """
                  link "óww",
                       "ew",
                       Routes.some_looooooooooooooooooonger_path(@conn, :create),
                       "Ewe"
                  """,
                  no_parens: ["link"]

    assert_format bad,
                  """
                  link "óww",
                       "ew",
                       Routes.some_looooooooooooooooooonger_path(
                         @conn,
                         :create
                       ),
                       "Ewe"
                  """,
                  no_parens: ["link"],
                  line_length: 40
  end

  test "greets the world naa" do
    bad = [
      """
        link "óww",
          "ew",
          Routes.some_looooooooooooooooooonger_path(@conn, :create),
            "Ewe"   ,
          fn(ef,fe)->
      """,
      """
      link "óww",
      "ew",
      Routes.some_looooooooooooooooooonger_path(@conn, :create),
        "Ewe"   ,
      fn->
      """
    ]

    assert_format bad,
                  [
                    """
                    link
                      "óww",
                      "ew",
                      Routes.some_looooooooooooooooooonger_path(@conn, :create),
                      "Ewe",
                      fn ef, fe ->
                    """,
                    """
                    link
                      "óww",
                      "ew",
                      Routes.some_looooooooooooooooooonger_path(@conn, :create),
                      "Ewe",
                      fn ->
                    """
                  ]

    assert_format bad,
                  [
                    """
                    link
                      "óww",
                      "ew",
                      Routes.some_looooooooooooooooooonger_path(
                        @conn,
                        :create
                      ),
                      "Ewe",
                      fn ef, fe ->
                    """,
                    """
                    link
                      "óww",
                      "ew",
                      Routes.some_looooooooooooooooooonger_path(
                        @conn,
                        :create
                      ),
                      "Ewe",
                      fn ->
                    """
                  ],
                  line_length: 40

    assert_format bad,
                  [
                    """
                    link "óww",
                         "ew",
                         Routes.some_looooooooooooooooooonger_path(@conn, :create),
                         "Ewe",
                         fn ef, fe ->
                    """,
                    """
                    link "óww",
                         "ew",
                         Routes.some_looooooooooooooooooonger_path(@conn, :create),
                         "Ewe",
                         fn ->
                    """
                  ],
                  no_parens: "link"

    assert_format bad,
                  [
                    """
                    link "óww",
                         "ew",
                         Routes.some_looooooooooooooooooonger_path(
                           @conn,
                           :create
                         ),
                         "Ewe",
                         fn ef, fe ->
                    """,
                    """
                    link "óww",
                         "ew",
                         Routes.some_looooooooooooooooooonger_path(
                           @conn,
                           :create
                         ),
                         "Ewe",
                         fn ->
                    """
                  ],
                  no_parens: "link",
                  line_length: 40
  end

  test "function call with do" do
    bad = """
      link "óww",
        "ew",
            "Ewe"
          do
    """

    assert_format bad,
                  """
                  link "óww",
                       "ew",
                       "Ewe" do
                  """

    assert_format bad,
                  """
                  link "óww",
                       "ew",
                       "Ewe" do
                  """,
                  no_parens: "link"
  end

  test "no args exits with status 1" do
    assert "Formatter was called without any arguments.\n" ==
             capture_io(:stderr, fn ->
               assert {:shutdown, 1} == catch_exit(PrettierEexFormatter.CLI.main([]))
             end)
  end

  test "unknown flags exits with status 1" do
    assert """
           Couldn't process some of the flags from arguments:
             -ww?
           Permitted flags:
             --line-length
             --no-parens
           """ ==
             capture_io(:stderr, fn ->
               assert {:shutdown, 1} == catch_exit(PrettierEexFormatter.CLI.main(["-ww?"]))
             end)
  end
end
