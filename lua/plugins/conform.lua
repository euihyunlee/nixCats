return {
    "conform.nvim",
    enabled = nixCats("general") or false,
    lazy = true,
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>F",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            desc = "[F]ormat buffer",
        },
    },
    after = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                nix = { "alejandra" },
                rust = { "rustfmt" },
                tex = { "tex-fmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                svelte = { "prettier" },
            },
        })
    end,
}
