{ pkgs, ... }: {
  programs.nixvim = {
    # This just enables NixVim.
    # If all you have is this, then there will be little visible difference
    # when compared to just installing NeoVim.
    enable = true;

    globals.mapleader = " ";

    clipboard.register = "unnamedplus";
    clipboard.providers.xclip.enable = true;
    autoCmd = [
      {
        event = [ "BufWinEnter" ];
        pattern = [ "*" ];
        command = "normal zR";
      }
    ];
    options = {
      number = true; # Show line numbers
      # relativenumber = true; # Show relative line numbers

      shiftwidth = 2; # Tab width should be 2
    };
    maps = {
      normal."<M-s>" = { action = "<cmd>:w<CR>"; };
      insert."<M-s>" = { action = "<cmd>:w<CR>"; };
      terminal = { };
    };
    # Of course, we can still use comfy vimscript:
    #extraConfigVim = builtins.readFile ./init.vim;
    # Or lua!
    extraConfigLua = builtins.readFile ./nvim/init.lua;

    # One of the big advantages of NixVim is how it provides modules for
    # popular vim plugins
    # Enabling a plugin this way skips all the boring configuration that
    # some plugins tend to require.
    plugins = {
      # ui
      alpha.enable = true;
      lualine.enable = true;
      neo-tree = {
        enable = true;
        enableRefreshOnWrite = true;
        filesystem.followCurrentFile.enabled = true;
        buffers.followCurrentFile.enabled = true;
      };
      which-key.enable = true;
      notify.enable = true;
      noice.enable = true;
      telescope = {
        enable = true;
        extensions = {
          frecency.enable = true;
          fzf-native.enable = true;
          project-nvim.enable = true;
        };
      };
      undotree.enable = true;

      # lang
      treesitter = {
        enable = true;
        # let's see if indentation works as expected
        indent = true;
        #folding = true;
      };
      treesitter-context.enable = true;
      lsp-format = {
        enable = true;
        lspServersToEnable = [ "elixirls" "rnix-lsp" ];
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rnix-lsp.enable = true;
          elixirls.enable = true;
          tsserver.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
        };
        keymaps = {
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
        };
      };

      # project
      project-nvim = {
        enable = true;
        detectionMethods = [ "pattern" "lsp" ];
        patterns = [ ".git" ];
      };
      gitsigns = {
        enable = true;
        onAttach.function = builtins.readFile ./nvim/gitsigns.lua;
      };
      gitmessenger.enable = true;
      todo-comments.enable = true;
      neorg.enable = true;

      # editing
      comment-nvim.enable = true;
      mini = {
        enable = true;
        modules = {
          ai = { };
          animate = { };
          bufremove = { };
          fuzzy = { };
          hipatterns = { };
          indentscope = { };
          move = { };
          pairs = { };
          surround = { };
          trailspace = { };
        };
      };
      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; } #For luasnip users.
          { name = "path"; }
          { name = "buffer"; }
        ];
        snippet.expand = "luasnip";
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end
            '';
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
      indent-blankline.enable = true;
      trouble.enable = true;

      # terminal
      toggleterm = {
        enable = true;
        startInInsert = true;
        size = ''function(term)
		  if term.direction == "horizontal" then
		    return 15
		  elseif term.direction == "vertical" then
		    return vim.o.columns * 0.4
		  end
		end'';
      };


      # sessions
      auto-session = {
        enable = true;
        sessionLens = {
          loadOnSetup = true;
          previewer = null;
        };
      };
      # Of course, there are a lot more plugins available.
      # You can find an up-to-date list here:
      # https://nixvim.pta2002.com/plugins
    };

    # There is a separate namespace for colorschemes:
    colorscheme = "onedark";
    # colorschemes.onedark.enable = true;





    # What about plugins not available as a module?
    # Use extraPlugins:
    extraPlugins = with pkgs.vimPlugins; [ lazygit-nvim vim-visual-multi nvim-spectre vim-illuminate onedarkpro-nvim ];
  };
}
