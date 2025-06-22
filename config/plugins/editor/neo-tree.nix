_:

{
  plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    popupBorderStyle = "none";
    # Collapse folder
    window.mappings."h".__raw = ''
      function(state)
        local node = state.tree:get_node()
        if node.type == "directory" and node:is_expanded() then
          require("neo-tree.sources.filesystem").toggle_directory(state, node)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end
    '';
    # Expand folder
    window.mappings."l".__raw = ''
      function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          if not node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          elseif node:has_children() then
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        end
      end
    '';
    window.mappings."s" = "";
    window.mappings."<space>" = "";
  };
}
