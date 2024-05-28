-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"

        -- Buffer
        ["<A-q>"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" },
        ["<A-k>"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<A-j>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<A-S-k>"] = {
          function() require("astrocore.buffer").move(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Move buffer tab right",
        },
        ["<A-S-j>"] = {
          function() require("astrocore.buffer").move(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Move buffer tab left",
        },
        ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<leader>c"] = false, -- disable original mappings

        -- Resize
        ["<A-;>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" },
        ["<A-'>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" },
        ["<A-[>"] = { "<cmd>vertical resize -5<CR>", desc = "Resize split left" },
        ["<A-]>"] = { "<cmd>vertical resize +5<CR>", desc = "Resize split right" },

        -- quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

        -- Telescope
        ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Projects" },
        ["<leader>fr"] = { "<cmd>Telescope ros ros<cr>", desc = "ROS" },
        ["<leader>fg"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" },

        -- ROS
        ["<leader>r"] = { desc = "󱨚 ROS" },
        ["<leader>rl"] = { function() require("ros-nvim.ros").open_launch_include() end, desc = "Open launch include" },
        -- show definition for messages/services in floating window
        ["<leader>rm"] = {
          function() require("ros-nvim.ros").show_message_definition() end,
          desc = "Show message definition",
        },
        ["<leader>rs"] = {
          function() require("ros-nvim.ros").show_service_definition() end,
          desc = "Show services definition",
        },

        -- NeoTree
        ["<leader>o"] = false,
        ["<C-e>"] = {
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end,
          desc = "Toggle Explorer Focus",
        },

        -- Terminal
        ["<C-\\>"] = { "<cmd>ToggleTerm size=20 direction=horizontal<cr>", desc = "Terminal: Toggle horizontal" },
        ["<A-\\>"] = { "<cmd>ToggleTerm size=40 direction=vertical<cr>", desc = "Terminal: Toggle horizontal" },
        ["<C-A-\\>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal: Toggle horizontal" },

        -- Markdown and LaTeX
        ["<leader>m"] = { desc = "󱁤 Compiler" },

        -- LSP
        ["<leader>lS"] = false,
        ["<leader>lo"] = { function() require("aerial").toggle() end, desc = "Language: Outline" },

        -- Obsidian
        -- ["<leader>o"] = { desc = "󰈙 Obsidian" },
        ["<leader>oq"] = { "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian: Quick search" },
        ["<leader>of"] = { "<cmd>ObsidianSearch<cr>", desc = "Obsidian: Search" },
        ["<leader>ob"] = { "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian: Back links" },
        ["<leader>ot"] = { "<cmd>ObsidianToday<cr>", desc = "Obsidian: Today" },
        ["<leader>oo"] = { "<cmd>ObsidianFollowLink<cr>", desc = "Obsidian: Follow link" },
        ["<leader>op"] = { "<cmd>ObsidianTemplate<cr>", desc = "Obsidian: Paste Template" },

        -- VimTex
        ["<leader>v"] = { desc = "󰈙 VimTex" },
        ["<leader>vo"] = { "<cmd>VimtexTocToggle<cr>", desc = "VimTex: Toggle toc" },
        ["<leader>vm"] = { "<cmd>VimtexCompile<cr>", desc = "VimTex: Compile" },
        ["<leader>vc"] = { "<cmd>VimtexClean<cr>", desc = "VimTex: Clean" },
        ["<leader>vv"] = { "<cmd>VimtexView<cr>", desc = "VimTex: View" },
        ["<leader>vt"] = { "<cmd>VimtexTocToggle<cr>", desc = "VimTex: TOC" },
      },

      -- Terminal Mode --
      t = {
        ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Terminal: Toggle horizontal" },
        ["<A-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Terminal: Toggle horizontal" },
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      -- Insert Mode --
      i = {
        ["<C-\\>"] = { "<Esc><Cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal: Toggle horizontal" },
        ["<A-\\>"] = { "<Esc><Cmd>ToggleTerm direction=vertical<CR>", desc = "Terminal: Toggle horizontal" },
      },

      -- Visual Mode --
      v = {
        ["J"] = { ":m '>+1<CR>gv=gv", desc = "Edit: Move this line down" },
        ["K"] = { ":m '<-2<CR>gv=gv", desc = "Edit: Move this line up" },
      },
    },
  },
}
