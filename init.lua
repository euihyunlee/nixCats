require("nixCatsUtils").setup({
    non_nix_value = true,
})

-- Bootstrap paq plugin manager when not using Nix
if not require("nixCatsUtils").isNixCats then
    local function clone_paq()
        local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
        local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
        if not is_installed then
            vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path })
            return true
        end
    end

    local function bootstrap_paq(packages)
        local first_install = clone_paq()
        vim.cmd.packadd("paq-nvim")
        local paq = require("paq")
        if first_install then
            vim.notify("Installing plugins... If prompted, hit Enter to continue.")
        end

        -- Read and install packages
        paq(packages)
        paq.install()
    end

    -- Bootstrap paq plugin manager (see `:h paq-bootstrapping`)
    bootstrap_paq({
        "savq/paq-nvim",
        "nvim-neorocks/lz.n",

        -- TODO: Add plugins; e.g.,
        -- { "catppuccin/nvim", as = "catppuccin-nvim" },
    })
end

-- Set vim globals, opts, and keymaps
require("config")

-- Load plugins via lz.n
require("lz.n").load("plugins")

-- Set colorscheme
vim.cmd.colorscheme("catppuccin")
