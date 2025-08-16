local keys = {
    {
        "<leader>ff",
        function()
            require("telescope.builtin").find_files()
        end,
        desc = "[F]ind [F]iles",
    },
    {
        "<leader>fg",
        function()
            require("telescope.builtin").live_grep()
        end,
        desc = "[F]ind [G]rep",
    },
    {
        "<leader>fb",
        function()
            require("telescope.builtin").buffers()
        end,
        desc = "[F]ind [B]uffers",
    },
    {
        "<leader>fd",
        function()
            require("telescope.builtin").diagnostics()
        end,
        desc = "[F]ind [D]iagnostics",
    },
    {
        "<leader>fh",
        function()
            require("telescope.builtin").help_tags()
        end,
        desc = "[F]ind [H]elp",
    },
    {
        "<leader>fj",
        function()
            require("telescope.builtin").jumplist()
        end,
        desc = "[F]ind [J]umplist",
    },
    {
        "<leader>fq",
        function()
            require("telescope.builtin").quickfix()
        end,
        desc = "[F]ind [Q]uickfix",
    },
    {
        "gd",
        function()
            require("telescope.builtin").lsp_definitions()
        end,
        desc = "[G]oto [D]efinitions",
    },
    {
        "gi",
        function()
            require("telescope.builtin").lsp_implementations()
        end,
        desc = "[G]oto [I]mplementations",
    },
    {
        "gr",
        function()
            require("telescope.builtin").lsp_references()
        end,
        desc = "[G]oto [R]eferences",
    },
    {
        "<leader>ds",
        function()
            require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "[D]ocument [S]ymbols",
    },
    {
        "<leader>ws",
        function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "[W]orkspace [S]ymbols",
    },
}

return {
    {
        "plenary.nvim",
        enabled = nixCats("general") or false,
        lazy = true,
    },
    {
        "telescope-fzf-native.nvim",
        enabled = nixCats("general") or false,
        lazy = true,
    },
    {
        "telescope.nvim",
        enabled = nixCats("general") or false,
        lazy = true,
        cmd = "Telescope",
        keys = keys,
        after = function()
            local lz = require("lz.n")
            lz.trigger_load("plenary.nvim")
            lz.trigger_load("telescope-fzf-native.nvim")

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-y>"] = "select_default",
                            ["<C-s>"] = "select_horizontal",
                        },
                    },
                },
            })

            require("telescope").load_extension("fzf")
        end,
    },
}
