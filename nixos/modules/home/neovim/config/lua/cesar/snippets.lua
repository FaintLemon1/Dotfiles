local luasnip = require("luasnip")
local snippet = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node
local repeat_node = require("luasnip.extras").rep

-- Friendly Snippets usa en algunos casos el nombre "latex" para el ámbito.
luasnip.filetype_extend("tex", { "latex" })

luasnip.add_snippets("tex", {
  snippet("beg", {
    text("\\begin{"),
    insert(1, "environment"),
    text({ "}", "  " }),
    insert(0),
    text({ "", "\\end{" }),
    repeat_node(1),
    text("}"),
  }),

  snippet("dm", {
    text({ "\\[", "  " }),
    insert(1),
    text({ "", "\\]" }),
  }),

  snippet("eq", {
    text({ "\\begin{equation*}", "  " }),
    insert(1),
    text({ "", "\\end{equation*}" }),
  }),

  snippet("ali", {
    text({ "\\begin{align*}", "  " }),
    insert(1),
    text({ "", "\\end{align*}" }),
  }),

  snippet("frac", {
    text("\\frac{"),
    insert(1, "numerador"),
    text("}{"),
    insert(2, "denominador"),
    text("}"),
  }),

  snippet("item", {
    text("\\item "),
    insert(0),
  }),
})
