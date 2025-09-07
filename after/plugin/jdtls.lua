-- ~/.config/nvim/ftplugin/java.lua
local api = vim.api

-- Start only for normal file buffers
if vim.bo.buftype ~= "" then return end

-- Buffer must have a real, readable file path
local fname = api.nvim_buf_get_name(0)
if fname == "" or vim.fn.filereadable(fname) == 0 then return end

-- Optional: avoid starting on preview/quickfix/etc.
if vim.bo.filetype ~= "java" then return end

local jdtls = require("jdtls")
local root_dir = require("jdtls.setup").find_root({
    ".git", "mvnw", "pom.xml", "gradlew", "build.gradle", "build.gradle.kts",
}) or vim.fn.getcwd()

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" }

local config = {
    cmd = cmd,
    root_dir = root_dir,
    workspace_folder = workspace_dir,
    settings = {
        java = {
            project = { sourcePaths = { "." } },
            configuration = { updateBuildConfiguration = "interactive" },
        },
    },
}

-- Start after the buffer is fully attached to avoid race with UI/dashboard
vim.schedule(function()
    if api.nvim_buf_is_valid(0) and api.nvim_buf_is_loaded(0) then
        jdtls.start_or_attach(config)
    end
end)
