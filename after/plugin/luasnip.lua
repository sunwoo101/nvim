require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})
