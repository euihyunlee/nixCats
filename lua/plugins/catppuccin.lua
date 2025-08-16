return {
    "catppuccin-nvim",
    enabled = nixCats("general") or false,
    lazy = true,
    colorscheme = "catppuccin",
    after = function()
        require("catppuccin").setup({
            flavour = "mocha",
            color_overrides = {
                mocha = {
                    base = "#000000",
                    -- mantle = "#000000",
                    -- crust = "#000000",
                },
            },
            transparent_background = false,
            no_bold = true,
            no_italic = true,
            no_underline = true,
            integrations = {
                which_key = true,
            },
        })
    end,
}
