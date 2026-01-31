-- Neovim Multipanel Configuration
-- Enable mouse support
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true

-- Terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    -- Automatically enter insert mode in terminal
    vim.cmd("startinsert")
  end,
})

-- Auto-enter insert mode when focusing terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          
          -- Default mappings
          api.config.mappings.default_on_attach(bufnr)
          
          -- Override the edit action to open in vertical split
          vim.keymap.set('n', '<CR>', function()
            local node = api.tree.get_node_under_cursor()
            if node and node.type == 'file' then
              -- Close nvim-tree temporarily to get the main window
              api.tree.close()
              -- Move to the editor window
              vim.cmd("wincmd l")
              -- Create vertical split
              vim.cmd("vsplit")
              -- Open the file
              vim.cmd("edit " .. node.absolute_path)
              -- Reopen nvim-tree
              api.tree.open()
              -- Move focus back to editor
              vim.cmd("wincmd l")
            else
              -- For directories, use default behavior
              api.node.open.edit()
            end
          end, { buffer = bufnr, silent = true, desc = 'Open in vsplit' })
          
          -- Add quit all keybindings that work in nvim-tree
          vim.keymap.set('n', '<leader>q', '<cmd>qa!<CR>', { buffer = bufnr, silent = true, desc = 'Quit all' })
          vim.keymap.set('n', '<leader>Q', '<cmd>qa!<CR>', { buffer = bufnr, silent = true, desc = 'Quit all' })
          vim.keymap.set('n', 'ZQ', '<cmd>qa!<CR>', { buffer = bufnr, silent = true, desc = 'Quit all' })
        end,
      })
    end,
  },

  -- Terminal support
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },

  -- Ollama AI integration
  {
    "David-Kunz/gen.nvim",
    config = function()
      require("gen").setup({
        model = "llama2",
        display_mode = "split",
        show_prompt = true,
        show_model = true,
        no_auto_close = true,
        init = function(options)
          pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
        end,
        command = function(options)
          return "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body"
        end,
      })
    end,
  },

  -- Color scheme for better visuals
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd[[colorscheme tokyonight-night]]
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
      })
    end,
  },

  -- Buffer line for better buffer management
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          diagnostics = false,
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = "slant",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          custom_areas = {
            right = function()
              return {
                { text = " SI Nvim ", guifg = "#7aa2f7", guibg = "#1a1b26", gui = "bold" },
                { text = " [✕ :qa!] ", guifg = "#f7768e", guibg = "#1a1b26", gui = "bold" },
              }
            end,
          },
        },
      })
    end,
  },
})

-- Key mappings
vim.g.mapleader = " "

-- QUIT ALL COMMANDS - Set multiple ways to quit
vim.api.nvim_create_user_command('QuitAll', function() vim.cmd('qa!') end, {})
vim.keymap.set("n", "<leader>q", "<cmd>qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "ZQ", "<cmd>qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "ZZ", "<cmd>qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })

-- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { silent = true })

-- ToggleTerm
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { silent = true })

-- Gen.nvim (Ollama)
vim.keymap.set({ "n", "v" }, "<leader>g", ":Gen<CR>", { silent = true })
vim.keymap.set("n", "<leader>gc", ":Gen Chat<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true })

-- Force quit all panels
vim.keymap.set("n", "<leader>q", ":qa!<CR>", { silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { silent = true, desc = "Quit all" })
vim.keymap.set("n", "<C-q>", ":qa!<CR>", { silent = true, desc = "Quit all" })
vim.keymap.set("n", "ZQ", ":qa!<CR>", { silent = true, desc = "Quit all" })