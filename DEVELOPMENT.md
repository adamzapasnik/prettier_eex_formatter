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
- Build escript

```sh
  rm -rf _build
  rm prettier_eex_formatter prettier_eex_formatter.zip prettier_eex_formatter.tar.gz
  MIX_ENV=prod mix escript.build
  zip prettier_eex_formatter.zip prettier_eex_formatter
  tar -zcvf prettier_eex_formatter.tar.gz prettier_eex_formatter
```

- Attach prettier_eex_formatter archives to the release on github https://github.com/adamzapasnik/prettier_eex_formatter/releases
