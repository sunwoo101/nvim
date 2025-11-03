-- Fix Roslyn markdown formatting for hover/docs (works with blink.cmp too)
local util = vim.lsp.util
local orig_convert = util.convert_input_to_markdown_lines

util.convert_input_to_markdown_lines = function(input, ...)
    if type(input) == "table" and input.kind == "markdown" and type(input.value) == "string" then
        local s = input.value

        -- 1️⃣ Add newlines only for "\. " patterns (your docs)
        s = s:gsub("\\%.%s+(%u)", ".\n%1")

        -- 2️⃣ Unescape all remaining "\." to "."
        s = s:gsub("\\%.", ".")

        -- 3️⃣ Unescape other markdown escapes like \* \[ \] etc.
        s = s:gsub("\\([%[%]%(%){}`*_#+%-])", "%1")

        -- 4️⃣ Normalize Windows newlines (CRLF)
        s = s:gsub("\r\n", "\n")

        input = { kind = "markdown", value = s }
    end

    return orig_convert(input, ...)
end

local function undobreak()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-g>u", true, false, true), "n", false)
end

require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept({ callback = undobreak() })
                else
                    return cmp.select_and_accept({ callback = undobreak() })
                end
            end,
            'snippet_forward',
            'fallback'
        },
    },
    cmdline = {
        enabled = true,         -- or remove if you had set it to false
        keymap = {
            preset = "inherit", -- start from your top-level keymap
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
        },
        completion = {
            menu = { auto_show = true }, -- optional: show popup automatically
        },
    },
    appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
            Class         = "󰠱",
            Function      = "󰊕",
            Method        = "󰆧",
            Variable      = "󰀫",
            Field         = "󰈽",
            Property      = "",
            Interface     = "",
            Module        = "",
            File          = "",
            Folder        = "",
            Snippet       = "󰘍",
            Text          = "󰉿",
            Keyword       = "󰌋",
            Unit          = "",
            Value         = "󰎠",
            Enum          = "",
            Color         = "󰏘",
            Struct        = "",
            Event         = "",
            Operator      = "󰆕",
            TypeParameter = "",
        },
    },
    completion = {
        trigger = { show_in_snippet = true },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
            update_delay_ms = 50,
            window = { border = "rounded" },
        },
        menu = {
            auto_show = true,
            border = "rounded",
            draw = {
                columns = {
                    { "kind_icon", "kind",              gap = 1 },
                    { "label",     "label_description", gap = 1 },
                },
            }
        },
        ghost_text = { enabled = true, show_with_menu = true },
        accept = { auto_brackets = { enabled = true }, },
    },
    snippets = { preset = 'luasnip' },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "lua",
    },
    signature = { enabled = false },
})

local ok_ls, ls = pcall(require, "luasnip")

-- <Tab>: jump/expand snippet → completion next → literal Tab
vim.keymap.set({ "i", "s" }, "<Tab>", function()
    -- Neovim built-in snippet
    if vim.snippet and vim.snippet.active() then
        vim.snippet.jump(1)
        return ""
    end
    -- LuaSnip
    if ok_ls and ls.expand_or_jumpable() then
        ls.expand_or_jump()
        return ""
    end
    -- Completion menu
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    end
    return "<Tab>"
end, { expr = true, silent = true })

-- <S-Tab>: jump backward → completion prev → literal <S-Tab>
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    if vim.snippet and vim.snippet.active() then
        vim.snippet.jump(-1)
        return ""
    end
    if ok_ls and ls.jumpable(-1) then
        ls.jump(-1)
        return ""
    end
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    end
    return "<S-Tab>"
end, { expr = true, silent = true })
