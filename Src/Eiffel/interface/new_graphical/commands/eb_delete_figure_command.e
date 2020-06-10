note
	description: "Command to delete diagram components."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DELETE_FIGURE_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			menu_name,
			description
		end

create
	make

feature -- Basic operations

	execute
			-- Display information about `Current'.
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (Interface_names.e_Diagram_delete_figure, tool.develop_window.window, Void)
		end

	execute_with_class_stone (a_stone: CLASSI_FIGURE_STONE)
			-- Remove `a_stone' from diagram.
			-- (And its relations.)
		local
			l_world: EIFFEL_WORLD
			es_class: ES_CLASS
			class_fig: EIFFEL_CLASS_FIGURE
			old_x, old_y: INTEGER
			l_projector: EIFFEL_PROJECTOR
			remove_links: LIST [ES_ITEM]
		do
			l_world := tool.world
			class_fig ?= a_stone.source
			if class_fig /= Void then
				old_x := class_fig.port_x
				old_y := class_fig.port_y
				l_projector := tool.projector
				es_class := class_fig.model
				remove_links := es_class.needed_links
				tool.restart_force_directed
				history.do_named_undoable (
					interface_names.t_diagram_erase_class_cmd (es_class.name_32),
					[<<agent l_world.remove_class_virtual (class_fig, remove_links), agent l_projector.full_project, agent tool.restart_force_directed, agent l_world.update_cluster_legend>>],
					[<<agent l_world.reinclude_class (class_fig, remove_links, old_x, old_y), agent l_projector.full_project, agent tool.restart_force_directed, agent l_world.update_cluster_legend>>])
			end
		end

	execute_with_class_list (a_stone: CLASS_FIGURE_LIST_STONE)
			-- Remove `a_stone' from diagram.
		local
			undo_list: ARRAYED_LIST [TUPLE [port_x: INTEGER; port_y: INTEGER; needed_links: LIST [ES_ITEM]]]
			l_classes: LIST [EIFFEL_CLASS_FIGURE]
			l_world: EIFFEL_WORLD
		do
			from
				l_classes := a_stone.classes
				create undo_list.make (l_classes.count)
				l_classes.start
			until
				l_classes.after
			loop
				undo_list.extend ([l_classes.item.port_x, l_classes.item.port_y, l_classes.item.model.needed_links])
				l_classes.forth
			end

			l_world := tool.world

			history.do_named_undoable (
				interface_names.t_diagram_erase_classes_cmd,
				[<<agent remove_class_list (a_stone.classes), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>],
				[<<agent reinclude_class_list (a_stone.classes, undo_list), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>])
		end

	execute_with_cluster_stone (a_stone: CLUSTER_FIGURE_STONE)
			-- Remove `a_stone' from diagram.
			-- (And its relations.)
		local
			l_world: EIFFEL_WORLD
			es_cluster: ES_CLUSTER
			cluster_fig: EIFFEL_CLUSTER_FIGURE
			l_projector: EIFFEL_PROJECTOR
			remove_links: LIST [ES_ITEM]
			remove_classes: like classes_to_remove_in_cluster
			cf: EIFFEL_CLASS_FIGURE
		do
			l_world := tool.world
			es_cluster := a_stone.source.model
			cluster_fig := a_stone.source
			if cluster_fig /= Void then
				l_projector := tool.projector

				remove_links := es_cluster.needed_links
				remove_classes := classes_to_remove_in_cluster (es_cluster)
				from
					remove_classes.start
				until
					remove_classes.after
				loop
					cf := remove_classes.item.figure
					remove_links.append (cf.model.needed_links)
					remove_classes.forth
				end

				history.do_named_undoable (
						interface_names.t_diagram_erase_cluster_cmd (es_cluster.name_32),
						[<<agent l_world.remove_cluster_virtual (cluster_fig, remove_links, remove_classes), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>],
						[<<agent l_world.reinclude_cluster (cluster_fig, remove_links, remove_classes), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>])
			end
		end

	execute_with_link_midpoint (a_stone: EG_EDGE)
			-- Remove `a_stone' from diagram.
		local
			line: EIFFEL_LINK_FIGURE
			old_edges, new_edges: LIST [EG_EDGE]
			l_projector: EIFFEL_PROJECTOR
		do
			line ?= a_stone.corresponding_line
			if line /= Void then
				old_edges := line.edges
				new_edges := old_edges.twin
				if new_edges.has (a_stone) then
					new_edges.prune_all (a_stone)
					a_stone.hide
					l_projector := tool.projector
					history.do_named_undoable (
						interface_names.t_diagram_delete_midpoint_cmd,
						[<<agent line.reset, agent line.retrieve_edges (new_edges), agent l_projector.full_project>>],
						[<<agent line.reset, agent line.retrieve_edges (old_edges), agent l_projector.full_project>>])
				end
			end
		end

	execute_with_inheritance_stone (a_stone: INHERIT_STONE)
			-- Remove `a_stone' from diagram.
		local
			l_item: ES_ITEM
			fig: EIFFEL_INHERITANCE_FIGURE
			l_projector: EIFFEL_PROJECTOR
			l_is_non_conforming: BOOLEAN
		do
			fig := a_stone.source
			l_item ?= fig.model
			if l_item /= Void then
				l_projector := tool.projector
				l_is_non_conforming := a_stone.source.model.is_non_conforming
				history.do_named_undoable (
					interface_names.t_diagram_delete_inheritance_link_cmd (fig.model.ancestor.name_32, fig.model.descendant.name_32, l_is_non_conforming),
					[<<agent l_item.disable_needed_on_diagram, agent l_projector.full_project>>],
					[<<agent l_item.enable_needed_on_diagram, agent l_projector.full_project>>])
			end
		end

	execute_with_client_stone (a_stone: CLIENT_STONE)
			-- Remove `a_stone' from diagram.
		local
			l_item: ES_ITEM
			fig: EIFFEL_CLIENT_SUPPLIER_FIGURE
			l_projector: EIFFEL_PROJECTOR
		do
			fig := a_stone.source
			l_item ?= fig.model
			if l_item /= Void then
				l_projector := tool.projector
				history.do_named_undoable (
					interface_names.t_diagram_delete_client_link_cmd (fig.model.name_32),
					[<<agent l_item.disable_needed_on_diagram, agent l_projector.full_project>>],
					[<<agent l_item.enable_needed_on_diagram, agent l_projector.full_project>>])
			end
		end

feature -- Access

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_class_stone)
			Result.drop_actions.extend (agent execute_with_cluster_stone)
			Result.drop_actions.extend (agent execute_with_link_midpoint)
			Result.drop_actions.extend (agent execute_with_inheritance_stone)
			Result.drop_actions.extend (agent execute_with_client_stone)
			Result.drop_actions.extend (agent execute_with_class_list)
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_reset_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_reset_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_remove
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_remove
		end

	name: STRING = "Delete_hole"
			-- Name of the command. Used to store the command in the
			-- preferences.

	menu_name: STRING_GENERAL
			-- Name on corresponding menu items
		do
			Result := interface_names.m_remove_from_diagram
		end

feature {NONE} -- Implementation

	remove_class_list (a_list: LIST [EIFFEL_CLASS_FIGURE])
			-- Remove all classes in `a_list'.
		local
			l_world: EIFFEL_WORLD
			es_class: ES_CLASS
			class_fig: EIFFEL_CLASS_FIGURE
			l_links: LIST [ES_ITEM]
		do
			l_world := tool.world
			from
				a_list.start
			until
				a_list.after
			loop
				class_fig := a_list.item
				es_class := class_fig.model
				es_class.disable_needed_on_diagram
				from
					l_links := es_class.needed_links
					l_links.start
				until
					l_links.after
				loop
					l_links.item.disable_needed_on_diagram
					l_links.forth
				end
				a_list.forth
			end
			tool.projector.full_project
		end

	reinclude_class_list (a_list: LIST [EIFFEL_CLASS_FIGURE]; undo_list: LIST [TUPLE [port_x: INTEGER; port_y: INTEGER; needed_links: LIST [ES_ITEM]]])
			-- Reinclude all classes in `a_list' to position in `undo_list' TUPLE and reinclude all links in `undo_list'.
		local
			l_world: EIFFEL_WORLD
			es_class: ES_CLASS
			class_fig: EIFFEL_CLASS_FIGURE
			remove_links: LIST [ES_ITEM]
			l_item: TUPLE [port_x: INTEGER; port_y: INTEGER; needed_links: LIST [ES_ITEM]]
		do
			l_world := tool.world
			from
				a_list.start
				undo_list.start
			until
				a_list.after
			loop
				class_fig := a_list.item
				es_class := class_fig.model
				l_item := undo_list.item
				remove_links := l_item.needed_links
				l_world.reinclude_class (class_fig, remove_links, l_item.port_x, l_item.port_y)
				a_list.forth
				undo_list.forth
			end
			tool.projector.full_project
		end

	classes_to_remove_in_cluster (a_cluster: ES_CLUSTER): LIST [TUPLE [figure: EIFFEL_CLASS_FIGURE; port_x: INTEGER; port_y: INTEGER]]
			-- All class figures in `a_cluster' that are needed on diagram plus ther positions.
		local
			l_linkables: LIST [EG_LINKABLE]
			es_class: ES_CLASS
			class_fig: EIFFEL_CLASS_FIGURE
		do
			from
				create {ARRAYED_LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]} Result.make (5)
				l_linkables := a_cluster.flat_linkables
				l_linkables.start
			until
				l_linkables.after
			loop
				es_class ?= l_linkables.item
				if es_class /= Void and then es_class.is_needed_on_diagram then
					class_fig ?= tool.world.figure_from_model (es_class)
					if class_fig /= Void then
						Result.extend ([class_fig, class_fig.port_x, class_fig.port_y])
					end
				end
				l_linkables.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
