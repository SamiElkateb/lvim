-- core --

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

--
lvim.plugins = {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "christoomey/vim-tmux-navigator"
  },
  {
    "ThePrimeagen/harpoon"
  },
  {
    "ThePrimeagen/git-worktree.nvim"
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  },
  { "mxsdev/nvim-dap-vscode-js" },
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  { "mfussenegger/nvim-dap-python" },
  { "tpope/vim-surround" },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup(
          {
            filetypes = {
              ["*"] = false, 
            },
          }
        )                              -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "ansible-vault view " .. vim.env.HOME .. "/.vault/openai",
        actions_paths = {
          vim.env.HOME .. "/.config/lvim/options/chatgpt.json",
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "mandos/nvim-helm",
    config = function()
      require("helm").setup()
    end,
  }
}
