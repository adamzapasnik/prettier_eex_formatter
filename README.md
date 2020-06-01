# PrettierEexFormatter

This escript is used in prettier eex plugin to format *multiline expressions*.

# Usage

This project is used by [prettier-plugin-eex](https://github.com/DiodonHystrix/prettier-plugin-eex)

Build escript
```MIX_ENV=prod mix escript.build```

Provide code that is base64 encoded.

Optional options:
  * --line-length
  
  --no-parens

Example:
```./prettier_eex_formatter base64encoded_code another_base64encoded_code --line-length=80 --no-parens=link,form_for```




# Development

Development information can be found [here](DEVELOPMENT.md)