indexing
	description	: "Command to fill a cluster with all its classes."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FILL_CLUSTER_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Basic operations

	execute is
			-- Perform on center cluster.
		local
			cd: CLUSTER_DIAGRAM
		do
			cd ?= tool.cluster_view
			if cd /= Void then
				cd.center_cluster.add_all_classes
				tool.reset_history
				tool.projector.project
			end
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Add all classes of `a_stone'.
		local
			clfs: CLUSTER_FIGURE_STONE
			clf: CLUSTER_FIGURE
			cd: CLUSTER_DIAGRAM
		do
			cd ?= tool.cluster_view
			clfs ?= a_stone
			if clfs /= Void and then clfs.source.world = cd then
				clfs.source.add_all_classes
				clfs.source.update_minimum_size
			else
				if cd /= Void then
					clf := cd.cluster_figure_by_cluster (a_stone.cluster_i)
					if clf /= Void then
						clf.add_all_classes
						clf.update_minimum_size
						tool.reset_history
						tool.projector.project
					end
				end
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_cluster_stone)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_fill_cluster
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_fill_cluster
		end

	name: STRING is "Cluster_filling"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_FILL_CLUSTER_COMMAND
