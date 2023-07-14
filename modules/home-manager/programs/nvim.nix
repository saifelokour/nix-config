{ pkgs, ... }: {
  programs.nixvim = {
    # This just enables NixVim.
    # If all you have is this, then there will be little visible difference
    # when compared to just installing NeoVim.
    enable = true;

    globals.mapleader = " ";

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
      relativenumber = true; # Show relative line numbers

      shiftwidth = 2; # Tab width should be 2
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
        window = {
          mappings = {
            "<space>" = "none";
            "<2-LeftMouse>" = "open";
            "<cr>" = "open";
            "<esc>" = "revert_preview";
            P = { command = "toggle_preview"; config = { use_float = true; }; };
            l = "focus_preview";
            S = "open_split";
            # S = "split_with_window_picker"; 
            s = "open_vsplit";
            # s = "vsplit_with_window_picker"; 
            t = "open_tabnew";
            #"<cr>" = "open_drop"; 
            # t = "open_tab_drop"; 
            w = "open_with_window_picker";
            C = "close_node";
            z = "close_all_nodes";
            # Z = "expand_all_nodes"; 
            R = "refresh";
            a = {
              command = "add";
              # some commands may take optional config options, see :h neo-tree-mappings for details 
              config = {
                show_path = "none";
                # "none", "relative", "absolute" 
              };
            };
            A = "add_directory";
            # also accepts the config.show_path and config.insert_as options. 
            d = "delete";
            r = "rename";
            y = "copy_to_clipboard";
            x = "cut_to_clipboard";
            p = "paste_from_clipboard";
            c = "copy";
            # takes text input for destination, also accepts the config.show_path and config.insert_as options 
            m = "move";
            # takes text input for destination, also accepts the config.show_path and config.insert_as options 
            e = "toggle_auto_expand_width";
            q = "close_window";
            "?" = "show_help";
            "<" = "prev_source";
            ">" = "next_source";
          };
        };
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
      project-nvim.enable = true;
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
          sessions = { };
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
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
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
      };
      # Of course, there are a lot more plugins available.
      # You can find an up-to-date list here:
      # https://nixvim.pta2002.com/plugins
    };

    # There is a separate namespace for colorschemes:
    colorschemes.onedark.enable = true;




    # What about plugins not available as a module?
    # Use extraPlugins:
    extraPlugins = with pkgs.vimPlugins; [ lazygit-nvim vim-visual-multi nvim-spectre vim-illuminate ];
  };
}
