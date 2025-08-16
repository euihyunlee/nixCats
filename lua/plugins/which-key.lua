return {
    "which-key.nvim",
    enabled = nixCats("general") or false,
    lazy = true,
    event = "DeferredUIEnter",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Local keymaps",
        },
    },
    after = function()
        require("which-key").setup({
            spec = {
                { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>f", group = "[F]ind" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "[H]unk", mode = { "n", "v" } },
                { "<leader>w", group = "[W]orkspace" },
            },
        })
    end,
}
