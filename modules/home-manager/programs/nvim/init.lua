local prettier = {
  formatCommand = [[ prettier --stdin-filepath ${INPUT} ]],
  formatStdin = true
}
local lua_format = {
  formatCommand = [[ lua-format --tab-width=2 --indent-width=2 --spaces-inside-table-braces ${INPUT} ]],
  formatStdin = true
}
require("lspconfig").efm.setup {
  on_attach = require("lsp-format").on_attach,
  init_options = { documentFormatting = true },
  filetypes = {
    'javascript', 'typescript', 'javascriptreact', 'typescriptreact',
    'javascript.jsx', 'typescript.tsx', 'lua'
  },
  settings = {
    languages = {
      typescript = { prettier },
      javascript = { prettier },
      ["typescript.tsx"] = { prettier },
      ["javascript.jsx"] = { prettier },
      typescriptreact = { prettier },
      javascriptreact = { prettier },
      json = { prettier },
      lua = { lua_format }
    }
  }
}

local wk = require("which-key")
wk.register({
  g = {
    name = "+goto",
    d = { "<cmd>Telescope lsp_definitions<cr>", "definition" },
    D = { "<cmd>Telescope lsp_references<cr>", "references" },
    I = { "<cmd>Telescope lsp_implementations<cr>", "implementations" },
    t = { "<cmd>Telescope lsp_type_definitions<cr>", "type definition" }
  },
  s = { name = "+surround" },
  ["<C-S>"] = { "<cmd>w<cr>", "save" },
  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
  ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
  ["<leader>"] = {
    [","] = {
      "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer"
    },
    ["'"] = { "<cmd>Telescope resume<cr>", "Resume search" },
    ["/"] = { "<cmd>Telescope live_grep<cr>", "Find in file" },
    [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
    ["<space>"] = { "<Cmd>Telescope frecency workspace=CWD<CR>", "Find File" },
    ["`"] = { "<cmd>e #<cr>", "Switch to Other Buffer" },
    ["-"] = { "<C-W>s", "Split window below" },
    ["|"] = { "<C-W>v", "Split window right" },
    e = {
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.loop.cwd()
        })
      end, "Explorer NeoTree (cwd)"
    },
    f = {
      name = "+file/find",
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      r = { "<cmd>Telescope frecency<cr>", "Open Recent File" },
      p = { "<cmd>Telescope projects<cr>", "Open project" },
      n = { "<cmd>enew<cr>", "New File" }
    },
    g = {
      name = "+git",
      h = { name = "+hunks" },
      c = { "<cmd>Telescope git_commits<CR>", "commits" },
      s = { "<cmd>Telescope git_status<CR>", "status" },
      g = { "<cmd>LazyGit<CR>", "LazyGit" }
    },
    b = {
      name = "+buffer",
      d = {
        function() require("mini.bufremove").delete(0, false) end,
        "Delete Buffer"
      },
      D = {
        function() require("mini.bufremove").delete(0, true) end,
        "Delete Buffer (Force)"
      }
    },
    c = {
      name = "+code",
      f = { function() vim.lsp.buf.format() end, "Format Buffer" }
    },
    q = {
      name = "+quit/session",
      q = { "<cmd>qa<CR>", "quit" },
      Q = { "<cmd>qa!<CR>", "force quit" }
    },
    s = {
      name = "+search",
      a = { "<cmd>Telescope autocommands<cr>", "Auto Commands" },
      b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
      c = { "<cmd>Telescope command_history<cr>", "Command History" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document diagnostics" },
      D = { "<cmd>Telescope diagnostics<cr>", "Workspace diagnostics" },
      g = { "<cmd>Telescope live_grep<cr>", "Find in file" },
      h = { "<cmd>Telescope help_tags<cr>", "Help Pages" },
      H = { "<cmd>Telescope highlights<cr>", "Search Highlight Groups" },
      k = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
      o = { "<cmd>Telescope vim_options<cr>", "Options" },
      r = {
        function() require("spectre").open() end, "Replace in files (Spectre)"
      },
      t = { "<cmd>TodoTelescope<cr>", "Todo" },
      T = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" },
      n = {
        l = { function() require("noice").cmd("last") end, "Noice Last Message" },
        h = { function() require("noice").cmd("history") end, "Noice History" },
        a = { function() require("noice").cmd("all") end, "Noice All" },
        d = { function() require("noice").cmd("dismiss") end, "Dismiss All" }
      }
    },
    u = { name = "+ui" },
    w = {
      name = "+windows",
      w = { "<C-W>p", "Other window" },
      d = { "<C-W>c", "Delete window" },
      ["-"] = { "<C-W>s", "Split window below" },
      ["|"] = { "<C-W>v", "Split window right" }
    },
    x = {
      name = "+diagnostics/quickfix",
      x = {
        "<cmd>TroubleToggle document_diagnostics<cr>",
        "Document Diagnostics (Trouble)"
      },
      X = {
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        "Workspace Diagnostics (Trouble)"
      },
      L = { "<cmd>TroubleToggle loclist<cr>", "Location List (Trouble)" },
      Q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List (Trouble)" },
      t = { "<cmd>TodoTrouble<cr>", "Todo (Trouble)" },
      T = {
        "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
        "Todo/Fix/Fixme (Trouble)"
      }
    }
  },
  ["[q"] = {
    function()
      if require("trouble").is_open() then
        require("trouble").previous({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then vim.notify(err, vim.log.levels.ERROR) end
      end
    end, "Previous trouble/quickfix item"
  },
  ["]q"] = {
    function()
      if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then vim.notify(err, vim.log.levels.ERROR) end
      end
    end, "Next trouble/quickfix item"
  },
  ["]t"] = {
    function() require("todo-comments").jump_next() end, "Next todo comment"
  },
  ["[t"] = {
    function() require("todo-comments").jump_prev() end, "Previous todo comment"
  }
})
