defmodule PrettierEexFormatter.MixProject do
  use Mix.Project

  def project do
    [
      app: :prettier_eex_formatter,
      version: "0.3.0",
      elixir: "~> 1.10",
      escript: [main_module: PrettierEexFormatter.CLI]
    ]
  end
end
