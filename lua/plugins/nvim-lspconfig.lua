local servers = {
    basedpyright = {
        settings = {
            basedpyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { "*" },
                },
            },
        },
    },
    clangd = {},
    lua_ls = {},
    -- See options for basedpyright
    ruff = {},
    rust_analyzer = {},
    texlab = {},
}

return {
    "nvim-lspconfig",
    enabled = nixCats("general") or false,
    lazy = false,
    after = function()
        if require("nixCatsUtils").isNixCats then
            for server, config in pairs(servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        else
            -- TODO: Load and configure mason
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                -- Define helper function to set keymaps
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
                end

                map("<leader>ca", vim.lsp.buf.code_action, "[A]ction", { "n", "x" })
                map("<leader>cr", vim.lsp.buf.rename, "[R]ename")

                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        if vim.g.have_nerd_font then
            local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
            local diagnostic_signs = {}
            for type, icon in pairs(signs) do
                diagnostic_signs[vim.diagnostic.severity[type]] = icon
            end
            vim.diagnostic.config({ signs = { text = diagnostic_signs } })
        end
    end,
}
