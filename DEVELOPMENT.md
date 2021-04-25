## Version Support Guidelines

Elixir itself supports 5 versions with security updates:
https://hexdocs.pm/elixir/compatibility-and-deprecations.html#content

OTP Supports the last 3 versions:
http://erlang.2086793.n4.nabble.com/OTP-Versions-and-Maint-Branches-td4722416.html

We generally aim to support the last 3 versions of Elixir and the last 3 versions of OTP.
However this is not a hard and fast rule and may change in the future.

*(Copied from https://github.com/elixir-lsp/elixir-ls/blob/master/DEVELOPMENT.md)*

**We trust ElixirLS team's experience on that matter.**

## Development

Clone repo

```https://github.com/adamzapasnik/prettier_eex_formatter.git```

Run tests
```mix test```

Or build escript
```MIX_ENV=prod mix escript.build```

## Packaging

- Bump the changelog
- Bump the version number in `mix.exs`
- Make PR
- Merge PR
- Make the tag from the new master
- Push the tag
- Build escript (run `bin/release`)

```sh
  rm -rf _build
  rm prettier_eex_formatter prettier_eex_formatter.zip prettier_eex_formatter.tar.gz
  MIX_ENV=prod mix escript.build
  zip prettier_eex_formatter.zip prettier_eex_formatter
  tar -zcvf prettier_eex_formatter.tar.gz prettier_eex_formatter
```

- Attach prettier_eex_formatter archives to the release on github https://github.com/adamzapasnik/prettier_eex_formatter/releases
