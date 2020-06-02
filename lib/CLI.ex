defmodule PrettierEexFormatter.CLI do
  def main([]) do
    IO.puts(:stderr, "Formatter was called without any arguments.")
    exit({:shutdown, 1})
  end

  def main(argv) do
    {opts, args} = parse_arguments(argv)
    formatter_opts = prepare_formatter_opts(opts)

    args
    |> Enum.map(&Base.decode64!/1)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&format(&1, formatter_opts))
    |> Enum.map(&Base.encode64/1)
    |> Enum.join("\n")
    |> IO.puts()
  end

  defp parse_arguments(argv) do
    OptionParser.parse(argv, strict: [line_length: :integer, no_parens: :string])
    |> case do
      {opts, args, []} ->
        {opts, args}

      {_, _, _} ->
        error_message = """
        Couldn't process some of the flags from arguments:
          #{Enum.join(argv, " ")}
        Permitted flags:
          --line-length
          --no-parens\
        """

        IO.puts(:stderr, error_message)
        exit({:shutdown, 1})
    end
  end

  defp prepare_formatter_opts([]), do: []

  defp prepare_formatter_opts(opts) when is_list(opts) do
    prepare_formatter_opts(Enum.into(opts, %{}), [])
  end

  defp prepare_formatter_opts(opts, formatter_opts) when map_size(opts) == 0 do
    formatter_opts
  end

  defp prepare_formatter_opts(%{line_length: line_length} = opts, formatter_opts) do
    formatter_opts = Keyword.put(formatter_opts, :line_length, line_length)

    prepare_formatter_opts(Map.delete(opts, :line_length), formatter_opts)
  end

  defp prepare_formatter_opts(%{no_parens: no_parens} = opts, formatter_opts) do
    locals_without_parens = no_parens |> String.split(",") |> Enum.into([], fn fun -> {String.to_atom(fun), :*} end)
    formatter_opts = Keyword.put(formatter_opts, :locals_without_parens, locals_without_parens)

    prepare_formatter_opts(Map.delete(opts, :no_parens), formatter_opts)
  end

  def format(code, formatter_opts) do
    cond do
      code =~ ~r/\sdo\z/m -> format_ends_with_do(code, formatter_opts)
      String.ends_with?(code, "->") -> format_ends_with_priv_fn(code, formatter_opts)
      true -> run_formatter(code, formatter_opts)
    end
  end

  defp format_ends_with_do(code, formatter_opts) do
    (code <> "\nend")
    |> run_formatter(formatter_opts)
    |> String.replace_trailing("\nend", "")
  end

  defp format_ends_with_priv_fn(code, formatter_opts) do
    (code <> "\nnil\nend")
    |> run_formatter(formatter_opts)
    |> String.trim()
    |> remove_added_code()
    |> String.split("\n")
    |> Enum.slice(0..-3)
    |> Enum.join("\n")
  end

  defp remove_added_code(code) do
    if String.ends_with?(code, ")") do
      fn_name_length = String.split(code, "(") |> Enum.at(0) |> String.length()
      extra_space = String.duplicate(" ", fn_name_length + 1)

      code
      |> String.replace("(\n ", "", global: false)
      |> String.replace("\n  ", "\n" <> extra_space)
      |> String.replace_trailing("\n)", "")
    else
      code
    end
  end

  defp run_formatter(code, opts) do
    code
    |> Code.format_string!(opts)
    |> IO.iodata_to_binary()
  end
end
