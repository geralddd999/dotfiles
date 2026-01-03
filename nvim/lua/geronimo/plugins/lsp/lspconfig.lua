return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- 1. LSP Keybinds (using the new LspAttach autocommand)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- Your keymaps remain exactly the same
                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)
                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        -- 2. Capabilities (for autocompletion)
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- 3. Configure Servers (The New 0.11 Way)
        -- We use vim.lsp.config to SET settings, and vim.lsp.enable to START them.

        -- --- CLANGD (C++) ---
        vim.lsp.config("clangd", {
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--offset-encoding=utf-16", -- Crucial for Neovim <-> Clangd encoding mismatch
            },
        })
        vim.lsp.enable("clangd") -- Actually start it

        -- --- LUA ---
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    completion = { callSnippet = "Replace" },
                },
            },
        })
        vim.lsp.enable("lua_ls")

        -- --- WEB DEV & OTHERS ---
        -- For servers with default config, we can just enable them directly.
        -- We loop through them to apply the 'capabilities' to all of them.
        local servers = {
            "emmet_language_server",
            "ts_ls",
            "gopls",
            "astro",
            "tailwindcss",
            "cssls",
            "html"
        }

        for _, server in ipairs(servers) do
            -- Apply capabilities to the default config before enabling
            vim.lsp.config(server, { capabilities = capabilities })
            vim.lsp.enable(server)
        end
    end,
}
