indexing
	description: "Command to show super cluster of entity the diagram of which%
				%is currently displayed."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SUPER_CLUSTER_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			stone: STONE
			cla_s: CLASSI_STONE
			clu_s: CLUSTER_STONE
			clu: CLUSTER_I
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
			end
			if clu /= Void then
				create clu_s.make (clu)
				if clu_s.is_valid then
					tool.set_stone (clu_s)
				end
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_super_cluster
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_super_cluster_diagram
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.F_super_cluster_diagram
		end

	name: STRING is "Supercluster_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_SUPER_CLUSTER_DIAGRAM_COMMAND
