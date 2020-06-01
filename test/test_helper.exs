ExUnit.start()

defmodule CLIHelper do
  defmacro assert_format(bad, good, opts \\ []) do
    quote bind_quoted: [bad: bad, good: good, opts: opts] do
      flags = opts |> Enum.map(fn {key, value} -> "--#{String.replace(to_string(key), "_", "-")}=#{value}" end)
      bads = bad |> List.wrap() |> Enum.map(&Base.encode64/1)
      goods = List.wrap(good) |> Enum.map(&String.trim/1)

      capture_io(fn ->
        PrettierEexFormatter.CLI.main(bads ++ flags)
      end)
      |> String.trim()
      |> String.split()
      |> Enum.with_index()
      |> Enum.each(fn
        {base64, index} ->
          assert Enum.at(goods, index) == Base.decode64!(base64)
      end)
    end
  end
end
