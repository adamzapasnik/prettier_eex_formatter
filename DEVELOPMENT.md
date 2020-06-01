# 
# Packaging

Bump the changelog
Bump the version number in `mix.exs`
Make PR
Merge PR
Make the tag from the new master
Push the tag
```bash
  rm -rf _build
  rm prettier_eex_formatter prettier_eex_formatter.zip prettier_eex_formatter.tar.gz
  MIX_ENV=prod mix escript.build
  zip prettier_eex_formatter.zip prettier_eex_formatter
  tar -zcvf prettier_eex_formatter.tar.gz prettier_eex_formatter
```
Attach prettier_eex_formatter archives to the release on github https://github.com/DiodonHystrix/prettier_eex_formatter/releases
