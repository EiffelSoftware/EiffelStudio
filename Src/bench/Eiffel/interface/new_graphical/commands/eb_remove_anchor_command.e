indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_REMOVE_ANCHOR_COMMAND
	
inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			description
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			create explain_dialog.make_with_text (Interface_names.e_diagram_remove_anchor)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.drop_actions.extend (agent execute_with_class)
			Result.drop_actions.extend (agent execute_with_class_list)
			Result.drop_actions.extend (agent execute_with_cluster)
		end

feature {NONE} -- Implementation

	execute_with_class (a_stone: CLASSI_FIGURE_STONE) is
			-- Set `is_fixed' to false for class in `a_stone'.
		do
			if a_stone.source.is_fixed then
				a_stone.source.set_is_fixed (False)
				tool.restart_force_directed
			else
				a_stone.source.set_is_fixed (True)
			end
		end
		
	execute_with_class_list (a_stone: CLASS_FIGURE_LIST_STONE) is
			-- Set `is_fixed' to false for all classes in `a_stone'.
		do
			from
				a_stone.classes.start
			until
				a_stone.classes.after
			loop
				a_stone.classes.item.set_is_fixed (not a_stone.classes.item.is_fixed)
				a_stone.classes.forth
			end
			tool.restart_force_directed
		end
		
	execute_with_cluster (a_stone: CLUSTER_STONE) is
			-- Set `is_fixed' to false for cluster in `a_stone'.
		local
			es_cluster: ES_CLUSTER
			cluster_fig: EG_CLUSTER_FIGURE
		do
			es_cluster := tool.graph.cluster_from_interface (a_stone.cluster_i)
			if es_cluster /= Void then
				cluster_fig ?= tool.world.figure_from_model (es_cluster)
				if cluster_fig /= Void then
					if cluster_fig.is_fixed then
						cluster_fig.set_is_fixed (False)
						tool.restart_force_directed
					else
						cluster_fig.set_is_fixed (True)
					end
				end
			end
		end

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.
			
	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.icon_remove_anchor
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := interface_names.f_diagram_remove_anchor
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_remove_anchor
		end

	name: STRING is "Anchor_remove"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_REMOVE_ANCHOR_COMMAND
