vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = {
        priority = 10,
        spacing = 4,
        prefix = '●'
    },
    severity_sort = true,
    underline = true,
    update_in_insert = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚',
            [vim.diagnostic.severity.WARN] = '󰀪',
            [vim.diagnostic.severity.INFO] = '󰋽',
            [vim.diagnostic.severity.HINT] = '󰌶',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
        },
    },
})

vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#51202A" })
vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = "#51412A" })

-- remove background for diagnostic virtual text
for _, severity in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    local hl = "DiagnosticVirtualText" .. severity
    vim.api.nvim_set_hl(0, hl, { fg = vim.fn.synIDattr(vim.fn.hlID(hl), "fg"), bg = "NONE" })
end


vim.lsp.enable('sourcekit-lsp')

-- ── QUIET CMDLINE (keep signatures working) ───────────────────────────────────
-- 1) Prevent pager blocks
vim.opt.more = false
if vim.fn.has("nvim-0.9") == 1 then vim.opt.cmdheight = 0 end
vim.opt.shortmess:append("filnxtToOFc") -- less chatty messages

-- 3) Only suppress the *junk* (keep real signatures/diagnostics)
local NOISE = {
    "no valid signature or incorrect lsp response",
    "activeParameter%s*=",
    "activeSignature%s*=",
    "cfgActiveSignature%s*=",
    "signatures%s*=%s*{", -- table dump from lsp_signature
}
local function is_noise(msg)
    msg = (tostring(msg) or ""):lower()
    for _, pat in ipairs(NOISE) do
        if msg:find(pat) then return true end
    end
    return false
end

-- 4) Wrap **every** path that writes to the bottom line
do
    -- a) :echo and friends
    local o_echo = vim.api.nvim_echo
    vim.api.nvim_echo = function(chunks, history, opts)
        local msg = table.concat(vim.tbl_map(function(c) return c[1] end, chunks))
        if is_noise(msg) then
            log(msg); return
        end
        return o_echo(chunks, history, opts)
    end

    -- b) plain stdout prints
    local o_out = vim.api.nvim_out_write
    vim.api.nvim_out_write = function(msg)
        if is_noise(msg) then
            log(msg); return
        end
        return o_out(msg)
    end

    -- c) error prints
    local o_err = vim.api.nvim_err_writeln
    vim.api.nvim_err_writeln = function(msg)
        if is_noise(msg) then
            log(msg); return
        end
        return o_err(msg)
    end

    -- d) Lua print()
    local o_print = _G.print
    _G.print = function(...)
        local parts = {}
        for i = 1, select("#", ...) do parts[i] = tostring(select(i, ...)) end
        local msg = table.concat(parts, " ")
        if is_noise(msg) then
            log(msg); return
        end
        return o_print(...)
    end

    -- e) vim.print() (Neovim 0.9+)
    if vim.print then
        local o_vprint = vim.print
        vim.print = function(...)
            local parts = {}
            for i = 1, select("#", ...) do parts[i] = tostring(select(i, ...)) end
            local msg = table.concat(parts, " ")
            if is_noise(msg) then
                log(msg); return
            end
            return o_vprint(...)
        end
    end

    -- f) notifications (some plugins route to notify)
    local o_notify = vim.notify
    vim.notify = function(msg, level, opts)
        if is_noise(msg) then
            log(msg); return
        end
        return o_notify(msg, level, opts)
    end
end

-- 5) Keep signature help enabled (don’t touch the handler)
-- If you use lsp_signature.nvim, ensure its debug is off:
pcall(function()
    local ok, sig = pcall(require, "lsp_signature")
    if ok and sig then
        sig.setup({
            debug = false,          -- <- IMPORTANT
            verbose = false,
            hint_enable = true,     -- keep your normal hints if you like
            floating_window = true, -- or false if you prefer inline
        })
    end
end)

-- 6) Helper to add new suppress patterns on the fly
vim.api.nvim_create_user_command("QuietAdd", function(o)
    table.insert(NOISE, o.args); print("Quiet: added pattern: " .. o.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("QuietLog", function() vim.cmd("edit " .. log_file) end, {})
-- ─────────────────────────────────────────────────────────────────────────────
