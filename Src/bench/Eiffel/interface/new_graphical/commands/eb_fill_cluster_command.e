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
			cluster_fig: EG_CLUSTER_FIGURE
			port_x, port_y: INTEGER
			old_count: INTEGER
		do
			check
				only_aviable_in_cluster_graph: tool.cluster_graph /= Void
			end
			cluster_fig ?= tool.cluster_view.figure_from_model (tool.cluster_graph.center_cluster)
			port_x := cluster_fig.port_x
			port_y := cluster_fig.port_y
			
			old_count := tool.cluster_graph.center_cluster.flat_linkables.count
			tool.cluster_graph.include_all_classes (tool.cluster_graph.center_cluster)
			if not tool.cluster_graph.last_included_classes.is_empty then
				tool.layout.layout_cluster_only (cluster_fig)
				tool.world.update
				
				cluster_fig.set_port_position (port_x, port_y)
				tool.restart_force_directed
				tool.reset_history
				tool.projector.full_project
			end
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Add all classes of `a_stone'.
		local
			es_cluster: ES_CLUSTER
			cluster_fig: EG_CLUSTER_FIGURE
			port_x, port_y: INTEGER
			old_count: INTEGER
		do
			check
				only_aviable_in_cluster_graph: tool.cluster_graph /= Void
			end
			es_cluster := tool.cluster_graph.cluster_from_interface (a_stone.cluster_i)
			if es_cluster /= Void then
				cluster_fig ?= tool.cluster_view.figure_from_model (es_cluster)
				port_x := cluster_fig.port_x
				port_y := cluster_fig.port_y
				
				old_count := es_cluster.flat_linkables.count
				tool.cluster_graph.include_all_classes (es_cluster)
				
				if not tool.cluster_graph.last_included_classes.is_empty then
					
					tool.layout.layout_cluster_only (cluster_fig)
					tool.world.update
					
					cluster_fig.set_port_position (port_x, port_y)
					tool.restart_force_directed
					tool.reset_history
					tool.projector.full_project
				end
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
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
