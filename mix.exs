defmodule PrettierEexFormatter.MixProject do
  use Mix.Project

  def project do
    [
      app: :prettier_eex_formatter,
      version: "0.2.0",
      elixir: "~> 1.8",
      escript: [main_module: PrettierEexFormatter.CLI]
    ]
  end
end
