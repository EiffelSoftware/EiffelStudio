indexing
	description: "Command to center the diagram on a stone"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CENTER_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end
		
create
	make

feature -- Basic operations

	execute is
			-- Display information about `Current'.
		local
			cla_s: CLASSI_STONE
			clu_s: CLUSTER_STONE
			clu: CLUSTER_I
			warned: BOOLEAN
		do
			if tool.class_view /= Void then
				cla_s := tool.class_stone
				if cla_s /= Void and then cla_s.is_valid then
					clu := cla_s.class_i.cluster
				end
			elseif tool.cluster_view /= Void then
				clu_s := tool.cluster_stone
				if clu_s /= Void and then clu_s.is_valid then
					clu := clu_s.cluster_i.parent_cluster
				end
			else
				create explain_dialog.make_with_text (Interface_names.e_Diagram_hole)
				explain_dialog.show_modal_to_window (tool.development_window.window)
				warned := True
			end
			if clu /= Void then
				create clu_s.make (clu)
				if clu_s.is_valid then
					tool.tool.set_stone (clu_s)
				end
			elseif not warned then
				create explain_dialog.make_with_text (Warning_messages.W_does_not_have_enclosing_cluster)
				explain_dialog.show_modal_to_window (tool.development_window.window)
			end
		end

	execute_with_stone (a_stone: STONE) is
			-- Create a development window and process `a_stone'.
		do
			tool.tool.set_stone (a_stone)
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (agent execute)
			Result.drop_actions.extend (agent execute_with_stone)
			Result.set_pebble_function (agent pebble)
		end

feature {NONE} -- Implementation

	pebble (x, y: INTEGER): STONE is
			-- pebble corresponding to class or cluster currently
			-- displayed in the context tool.
		local
			class_stone: CLASSI_STONE
			cluster_stone: CLUSTER_STONE
			tbi: EB_COMMAND_TOOL_BAR_BUTTON
		do
			Result := tool.tool.stone
			tbi := managed_toolbar_items.first
			class_stone ?= Result
			cluster_stone ?= Result
			if class_stone /= Void then
				tbi.set_accept_cursor (cursors.Cur_class)
			elseif cluster_stone /= Void then
				tbi.set_accept_cursor (cursors.Cur_cluster)
			end
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_center_diagram
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_retarget_diagram
		end

	name: STRING is "Center_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.
	
end -- class EB_CENTER_DIAGRAM_COMMAND
