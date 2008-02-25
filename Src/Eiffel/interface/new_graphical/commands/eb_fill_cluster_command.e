indexing
	description	: "Command to fill a cluster with all its classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FILL_CLUSTER_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			initialize,
			menu_name
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform on center cluster.
		local
			cluster_fig: EIFFEL_CLUSTER_FIGURE
		do
			if is_sensitive then
				check
					only_aviable_in_cluster_graph: tool.cluster_graph /= Void
				end
				cluster_fig ?= tool.cluster_view.figure_from_model (tool.cluster_graph.center_cluster)
				include_all_classes (cluster_fig)
			end
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Add all classes of `a_stone'.
		local
			es_cluster: ES_CLUSTER
			cluster_fig: EIFFEL_CLUSTER_FIGURE
			l_clusters: ARRAYED_LIST [ES_CLUSTER]
			fig_stone: CLUSTER_FIGURE_STONE
		do
			check
				only_aviable_in_cluster_graph: tool.cluster_graph /= Void
			end
			fig_stone ?= a_stone
			if fig_stone /= Void then
				include_all_classes (fig_stone.source)
			else
				l_clusters := tool.cluster_graph.cluster_from_interface (a_stone.group)
				if l_clusters /= Void then
					from
						l_clusters.start
					until
						l_clusters.after
					loop
						es_cluster := l_clusters.item
						cluster_fig ?= tool.cluster_view.figure_from_model (es_cluster)
						include_all_classes (cluster_fig)
						l_clusters.forth
					end

				end
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
		end

feature {NONE} -- Implementation

	include_all_classes (a_cluster_fig: EIFFEL_CLUSTER_FIGURE) is
			-- Include all classes into `a_cluster'.
		require
			a_cluster_exists: a_cluster_fig /= Void
		local
			port_x, port_y: INTEGER
			old_count: INTEGER
		do
			port_x := a_cluster_fig.port_x
			port_y := a_cluster_fig.port_y

			old_count := a_cluster_fig.model.flat_linkables.count
			tool.cluster_graph.include_all_classes (a_cluster_fig.model)

			if not tool.cluster_graph.last_included_classes.is_empty then
				a_cluster_fig.reset_user_size
				tool.world.update
				tool.layout.set_spacing ({ES_DIAGRAM_TOOL_PANEL}.default_bon_horizontal_spacing, {ES_DIAGRAM_TOOL_PANEL}.default_bon_vertical_spacing)
				tool.layout.layout_cluster_only (a_cluster_fig)

				a_cluster_fig.set_port_position (port_x, port_y)
				tool.restart_force_directed
				tool.reset_history
				tool.projector.full_project
			end
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_fill_cluster_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_fill_cluster_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_fill_cluster
		end

	menu_name: STRING_GENERAL is
			-- Name on corresponding menu items
		do
			Result := interface_names.m_include_all_classes
		end

	name: STRING is "Cluster_filling";
			-- Name of the command. Used to store the command in the
			-- preferences.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FILL_CLUSTER_COMMAND
