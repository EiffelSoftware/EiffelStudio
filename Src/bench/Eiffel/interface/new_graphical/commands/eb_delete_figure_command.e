indexing
	description	: "Command to delete diagram components."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DELETE_FIGURE_COMMAND

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
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_delete_figure)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

	execute_with_class_stone (a_stone: CLASSI_STONE) is
			-- Remove `a_stone' from diagram.
			-- (And its relations.)
		local
			cfs: CLASSI_FIGURE_STONE
			cf: CLASS_FIGURE
			cd: CONTEXT_DIAGRAM
		do
			cd ?= tool.class_view
			if cd = Void then
				cd ?= tool.cluster_view
			end
			check cd /= Void end
			cfs ?= a_stone
			if cfs /= Void and then cfs.source.world = cd then
				cf := cfs.source
			else
				cf := cd.class_figure_by_class (a_stone.class_i)
			end
			if cf /= Void and then cf /= cd.center_class then
				history.do_named_undoable (
					Interface_names.t_Diagram_delete_class_cmd,
					[<<~remove_class_figure (cf), ~project>>],
					[<<~restore_class_figure (cf), ~project>>])
			end
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Remove `a_stone' from diagram.
			-- (And its relations.)
		local
			clfs: CLUSTER_FIGURE_STONE
			cd: CLUSTER_DIAGRAM
			clf: CLUSTER_FIGURE
		do
			cd ?= tool.cluster_view
			if cd /= Void then
				clfs ?= a_stone
				if clfs /= Void and then clfs.source.world = cd then
					clf := clfs.source
				else
					clf := cd.cluster_figure_by_cluster (a_stone.cluster_i)
				end
				if clf /= Void and then clf /= cd.center_cluster then
					history.do_named_undoable (
						Interface_names.t_Diagram_delete_cluster_cmd,
						[<<~remove_cluster_figure (clf), ~project>>],
						[<<~restore_cluster_figure (clf), ~project>>])
				end
			end
		end

	execute_with_link_midpoint (a_stone: LINK_MIDPOINT) is
			-- Remove `a_stone' from diagram.
		local	
			i, a_x, a_y: INTEGER
			d: CONTEXT_DIAGRAM
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			if a_stone.world = d then
				i := a_stone.link_figure.index_of_midpoint (a_stone)
				a_x := ((a_stone.point.x_abs - d.point.x) / d.scale_x).rounded
				a_y := ((a_stone.point.y_abs - d.point.y) / d.scale_x).rounded
				history.do_named_undoable (
					Interface_names.t_Diagram_delete_midpoint_cmd,
					[<<a_stone~remove, ~project>>],
					a_stone~restore (i, a_x, a_y))
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_class_stone)
			Result.drop_actions.extend (~execute_with_cluster_stone)
			Result.drop_actions.extend (~execute_with_link_midpoint)
		end

feature {NONE} -- Implementation

	project is
			-- Call the projector.
		do
			tool.projector.project
		end

	remove_class_figure (a_class: CLASS_FIGURE) is
			-- Remove `a_class' from diagram.
			-- (And its relations).
		do
			a_class.remove_from_diagram (True)
		end
		
	restore_class_figure (a_class: CLASS_FIGURE) is
			-- Put `a_class' back on diagram.
		local
			d: CONTEXT_DIAGRAM
		do
			d ?= tool.class_view
			if d = Void then
				d ?= tool.cluster_view
			end
			check d /= Void end

			a_class.put_back_on_diagram (d)
		end

	remove_cluster_figure (a_cluster: CLUSTER_FIGURE) is
			-- Remove `a_cluster' from diagram.
			-- (And its relations).
		do
			a_cluster.recursive_remove_from_diagram (True)
		end
		
	restore_cluster_figure (a_cluster: CLUSTER_FIGURE) is
			-- Put `a_cluster' back on diagram.
		local
			d: CONTEXT_DIAGRAM
		do
			d ?= tool.cluster_view
			check d /= Void end

			a_cluster.put_back_on_diagram (d)
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_recycle_bin
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Remove figure"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Delete graphical items"
		end

	name: STRING is "Delete_hole"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.

end -- class EB_DELETE_FIGURE_COMMAND

