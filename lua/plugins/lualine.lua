return {
    {
        "nvim-web-devicons",
        enabled = nixCats("general") or true,
        lazy = true,
    },
    {
        "lualine.nvim",
        enabled = nixCats("general") or true,
        lazy = true,
        event = "DeferredUIEnter",
        after = function()
            require("lz.n").trigger_load("nvim-web-devicons")

            require("lualine").setup()
        end,
    },
}
