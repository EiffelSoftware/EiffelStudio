indexing
	description	: "Command to delete diagram components."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DELETE_FIGURE_COMMAND

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
			-- Display information about `Current'.
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_delete_figure)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
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

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.Icon_recycle_bin
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_remove
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_remove
		end

	name: STRING is "Delete_hole"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.
feature {NONE} -- Implementation

	execute_with_class_stone (a_stone: CLASSI_STONE) is
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
			es_class := l_world.model.class_from_interface (a_stone.class_i)
			if es_class /= Void then
				class_fig ?= l_world.figure_from_model (es_class)
				if class_fig /= Void then
					old_x := class_fig.port_x
					old_y := class_fig.port_y
					l_projector := tool.projector
					remove_links := es_class.needed_links
					tool.restart_force_directed
					history.do_named_undoable (
						interface_names.t_diagram_erase_class_cmd (es_class.name),
						[<<agent l_world.remove_class_virtual (class_fig, remove_links), agent l_projector.full_project, agent tool.restart_force_directed, agent l_world.update_cluster_legend>>],
						[<<agent l_world.reinclude_class (class_fig, remove_links, old_x, old_y), agent l_projector.full_project, agent tool.restart_force_directed, agent l_world.update_cluster_legend>>])
				end
			end
		end

	execute_with_class_list (a_stone: CLASS_FIGURE_LIST_STONE) is
			-- Remove `a_stone' from diagram.
		local
			undo_list: ARRAYED_LIST [TUPLE [INTEGER, INTEGER, LIST [ES_ITEM]]]
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

	remove_class_list (a_list: LIST [EIFFEL_CLASS_FIGURE]) is
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

	reinclude_class_list (a_list: LIST [EIFFEL_CLASS_FIGURE]; undo_list: LIST [TUPLE [INTEGER, INTEGER, LIST [ES_ITEM]]]) is
			-- Reinclude all classes in `a_list' to position in `undo_list' TUPLE and reinclude all links in `undo_list'.
		local
			l_world: EIFFEL_WORLD
			es_class: ES_CLASS
			class_fig: EIFFEL_CLASS_FIGURE
			remove_links: LIST [ES_ITEM]
			l_item: TUPLE [INTEGER, INTEGER, LIST [ES_ITEM]]
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
				remove_links ?= l_item.item (3)
				l_world.reinclude_class (class_fig, remove_links, l_item.integer_item (1), l_item.integer_item (2))
				a_list.forth
				undo_list.forth
			end
			tool.projector.full_project
		end

	execute_with_cluster_stone (a_stone: CLUSTER_STONE) is
			-- Remove `a_stone' from diagram.
			-- (And its relations.)
		local
			l_world: EIFFEL_WORLD
			es_cluster: ES_CLUSTER
			cluster_fig: EIFFEL_CLUSTER_FIGURE
			l_projector: EIFFEL_PROJECTOR
			remove_links: LIST [ES_ITEM]
			remove_classes: LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]]
			cf: EIFFEL_CLASS_FIGURE

			l_classes: LIST [CLASS_I]
			undo_list: ARRAYED_LIST [TUPLE [INTEGER, INTEGER, LIST [ES_ITEM]]]
			l_c_figs: ARRAYED_LIST [EIFFEL_CLASS_FIGURE]
			es_class: ES_CLASS
		do
			l_world := tool.world
			es_cluster := l_world.model.cluster_from_interface (a_stone.cluster_i)
			if es_cluster /= Void then
				cluster_fig ?= l_world.figure_from_model (es_cluster)
				if cluster_fig /= Void then
					l_projector := tool.projector

					remove_links := es_cluster.needed_links
					remove_classes := classes_to_remove_in_cluster (es_cluster)
					from
						remove_classes.start
					until
						remove_classes.after
					loop
						cf ?= remove_classes.item.item (1)
						remove_links.append (cf.model.needed_links)
						remove_classes.forth
					end

					history.do_named_undoable (
							interface_names.t_diagram_erase_cluster_cmd (es_cluster.name),
							[<<agent l_world.remove_cluster_virtual (cluster_fig, remove_links, remove_classes), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>],
							[<<agent l_world.reinclude_cluster (cluster_fig, remove_links, remove_classes), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>])
				end
			else
				from
					l_classes := a_stone.cluster_i.classes.linear_representation
					create undo_list.make (l_classes.count)
					create l_c_figs.make (l_classes.count)
					l_classes.start
				until
					l_classes.after
				loop
					es_class := l_world.model.class_from_interface (l_classes.item)
					if es_class /= Void then
						cf ?= l_world.figure_from_model (es_class)
						if cf /= Void and then cf.model.is_needed_on_diagram then
							l_c_figs.extend (cf)
							undo_list.extend ([cf.port_x, cf.port_y, cf.model.needed_links])
						end
					end
					l_classes.forth
				end

				history.do_named_undoable (
					interface_names.t_diagram_erase_classes_cmd,
					[<<agent remove_class_list (l_c_figs), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>],
					[<<agent reinclude_class_list (l_c_figs, undo_list), agent tool.restart_force_directed, agent l_world.update_cluster_legend>>])
			end
		end

	classes_to_remove_in_cluster (a_cluster: ES_CLUSTER): LIST [TUPLE [EIFFEL_CLASS_FIGURE, INTEGER, INTEGER]] is
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

	execute_with_link_midpoint (a_stone: EG_EDGE) is
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

	execute_with_inheritance_stone (a_stone: INHERIT_STONE) is
			-- Remove `a_stone' from diagram.
		local
			l_item: ES_ITEM
			fig: EIFFEL_INHERITANCE_FIGURE
			l_projector: EIFFEL_PROJECTOR
		do
			fig := a_stone.source
			l_item ?= fig.model
			if l_item /= Void then
				l_projector := tool.projector
				history.do_named_undoable (
					interface_names.t_diagram_delete_inheritance_link_cmd (fig.model.ancestor.name, fig.model.descendant.name),
					[<<agent l_item.disable_needed_on_diagram, agent l_projector.full_project>>],
					[<<agent l_item.enable_needed_on_diagram, agent l_projector.full_project>>])
			end
		end

	execute_with_client_stone (a_stone: CLIENT_STONE) is
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
					interface_names.t_diagram_delete_client_link_cmd (fig.model.name),
					[<<agent l_item.disable_needed_on_diagram, agent l_projector.full_project>>],
					[<<agent l_item.enable_needed_on_diagram, agent l_projector.full_project>>])
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_DELETE_FIGURE_COMMAND

