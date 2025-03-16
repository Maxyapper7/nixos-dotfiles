{ pkgs, lib, inputs, ... }:

{

  programs.nvf = {
    enable = true;
    settings.vim = {

      statusline.lualine.enable = true;
      autocomplete.nvim-cmp.enable = true;
      comments.comment-nvim.enable = true;
      filetree.neo-tree.enable = true;

      telescope = {
        enable = true;
        mappings.findFiles = "<leader><leader>";
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;

        nix.enable = true;
        bash.enable = true;
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
      };

      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
      };

      keymaps = [
        {
          key = "<C-n>";
          mode = [ "n" ];
          silent = true;
          action = ":Neotree filesystem reveal right<CR>";
        }
      ];
    };
  };

}
