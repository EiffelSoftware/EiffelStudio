indexing
	description	: "Command to change visibility of cluster layer."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOGGLE_CLUSTERS_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
		local
			world: CONTEXT_DIAGRAM
		do
			world := tool.world
			if world.cluster_layer.is_show_requested then
				world.hide_clusters
			else
				world.show_clusters
			end
			tool.update_size
			tool.projector.project
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_toggle_clusters
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Show/hide clusters"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Toggle visibility of graphical clusters"
		end

	name: STRING is "Cluster_visibility"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_TOGGLE_CLUSTERS_COMMAND
