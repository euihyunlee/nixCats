return {
    "gitsigns.nvim",
    enabled = nixCats("general") or false,
    lazy = true,
    event = "DeferredUIEnter",
    after = function()
        require("gitsigns").setup()
    end,
}
