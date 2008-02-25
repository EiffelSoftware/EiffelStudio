indexing
	description: "Command used for adding a certain class relations to diagram class figure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ADD_CLASS_FIGURE_RELATIONS_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			description,
			menu_name
		end

create
	make_for_clients, make_for_suppliers, make_for_descendents, make_for_ancestors

feature {NONE} -- Initialization

	make_for_clients (a_target: like tool) is
			-- Initialize the command with target `a_target' to handle client relations.
		require
			a_target_not_void: a_target /= Void
		do
			selected_implementation := adds_clients
			make (a_target)
		end

	make_for_suppliers (a_target: like tool) is
			-- Initialize the command with target `a_target' to handle supplier relations.
		require
			a_target_not_void: a_target /= Void
		do
			selected_implementation := adds_suppliers
			make (a_target)
		end

	make_for_ancestors (a_target: like tool) is
			-- Initialize the command with target `a_target' to handle ancestor relations.
		require
			a_target_not_void: a_target /= Void
		do
			selected_implementation := adds_ancestors
			make (a_target)
		end

	make_for_descendents (a_target: like tool) is
			-- Initialize the command with target `a_target' to handle descendent relations.
		require
			a_target_not_void: a_target /= Void
		do
			selected_implementation := adds_descendents
			make (a_target)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			l_sel_figures: ARRAYED_LIST [EG_FIGURE]
			l_class_list: ARRAYED_LIST [ES_CLASS]
			l_class: ES_CLASS
			l_class_added: BOOLEAN
		do
			if is_sensitive then
					-- Show relations for selected classes.
				l_sel_figures := tool.world.selected_figures
				if l_sel_figures /= Void and then not l_sel_figures.is_empty then
					from
						create l_class_list.make (5)
						l_sel_figures.start
					until
						l_sel_figures.after
					loop
						l_class ?= l_sel_figures.item.model
						if l_class /= Void then
							if l_class.class_i.is_compiled then
								l_class_list.extend (l_class)
								l_class_added := True
							end
						end
						l_sel_figures.forth
					end
					if l_class_added then
						calculate_relations_for_classes (l_class_list)
					end
				else
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (Interface_names.e_Diagram_add_class_figure_relations, tool.develop_window.window, Void)
				end
			end
		end

	relations_list_from_class_c (a_class: CLASS_C): LIST [CLASS_C] is
			-- Return all of the compiled relations for `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			inspect
				selected_implementation
			when adds_suppliers then
				Result := a_class.syntactical_suppliers
			when adds_clients then
				Result := a_class.syntactical_clients
			when adds_ancestors then
				Result := a_class.parents_classes
			when adds_descendents then
				Result := a_class.direct_descendants
			end
		end

	calculate_relations_for_classes (a_classes: ARRAYED_LIST [ES_CLASS]) is
			-- Calculate relations for `a_classes'.
		require
			a_classes_not_void: a_classes /= Void
			a_classes_not_empty: not a_classes.is_empty
		local
			l_relations_list: LIST [CLASS_C]
			l_added_class_relations_list: ARRAYED_LIST [ES_CLASS]
			l_added_class_relations_list_list: ARRAYED_LIST [ARRAYED_LIST [ES_CLASS]]
			l_class_graph: ES_CLASS_GRAPH
			l_added_class: ES_CLASS
			l_class_added: BOOLEAN
			l_cluster: ES_CLUSTER
			l_classes: ARRAYED_LIST [ES_CLASS]
		do
			l_class_graph := tool.class_graph
			if l_class_graph /= Void then
				from
					create l_added_class_relations_list_list.make (5)
					a_classes.start
				until
					a_classes.after
				loop
					l_cluster := a_classes.item.cluster
					l_relations_list := relations_list_from_class_c (a_classes.item.class_i.compiled_class)
					if l_relations_list /= Void then
						create l_added_class_relations_list.make (5)
						from
							l_relations_list.start
						until
							l_relations_list.after
						loop
							l_classes := l_class_graph.class_from_interface (l_relations_list.item.lace_class)
							l_added_class := Void
							if not l_classes.is_empty then
								l_added_class := l_classes.first
							end
							if l_added_class = Void then
									-- Class has not been generated on to the diagram so we need to add it.
								create l_added_class.make (l_relations_list.item.lace_class)
								l_class_graph.add_node (l_added_class)
								l_class_graph.add_node_relations (l_added_class)
								l_added_class.disable_needed_on_diagram
							end

							if not l_added_class.is_needed_on_diagram then
									-- Class has been generated but is not presently shown
								l_added_class_relations_list.extend (l_added_class)
								l_class_added := True
							else
								-- Class is already present and shown on the diagram
								-- Links from current may need to be added
							end
							l_relations_list.forth
						end
						l_added_class_relations_list_list.extend (l_added_class_relations_list)
					end
					a_classes.forth
				end
				if l_class_added then
					tool.history.do_named_undoable (undo_name, agent add_and_position_classes (a_classes, l_added_class_relations_list_list), agent hide_classes_from_diagram (l_added_class_relations_list_list))
				end
			end
		end

	undo_name: STRING is
			-- Undo name for operation of `Current'.
		do
			inspect
				selected_implementation
			when adds_suppliers then
				Result := "Class Figure Suppliers Added"
			when adds_clients then
				Result := "Class Figure Clients Added"
			when adds_ancestors then
				Result := "Class Figure Ancestors Added"
			when adds_descendents then
				Result := "Class Figure Descendents Added"
			end
		end

	hide_classes_from_diagram (a_class_list_list: ARRAYED_LIST [ARRAYED_LIST [ES_CLASS]]) is
			-- Hide all classes in `a_class_list_list' on diagram.
		local
			l_list: ARRAYED_LIST [ES_CLASS]
			a_links: LIST [ES_ITEM]
		do
			from
				a_class_list_list.start
			until
				a_class_list_list.after
			loop
				from
					l_list := a_class_list_list.item
					l_list.start
				until
					l_list.after
				loop
					l_list.item.disable_needed_on_diagram
					a_links := l_list.item.needed_links
					from
						a_links.start
					until
						a_links.after
					loop
						a_links.item.disable_needed_on_diagram
						a_links.forth
					end
					l_list.forth
				end
				a_class_list_list.forth
			end
			tool.projector.full_project
		end

	add_and_position_classes (a_class_list: ARRAYED_LIST [ES_CLASS]; a_class_list_list: ARRAYED_LIST [ARRAYED_LIST [ES_CLASS]]) is
			--
		require
			a_class_list_not_void: a_class_list /= Void and then not a_class_list.is_empty
			a_class_list_list_valid: a_class_list_list /= Void and then not a_class_list_list.is_empty
		local
			l_class_figure, l_supplier_class_figure: EIFFEL_CLASS_FIGURE
			l_x, l_y, l_x_offset, l_y_offset: INTEGER
			l_class_graph: ES_CLASS_GRAPH
			l_list: ARRAYED_LIST [ES_CLASS]
		do
			from
				a_class_list.start
				l_class_graph := tool.class_graph
				l_x_offset := tool.layout.horizontal_spacing
				l_y_offset := tool.layout.vertical_spacing
			until
				a_class_list.after or l_class_graph = Void
			loop
				from
					l_class_figure ?= tool.world.figure_from_model (a_class_list.item)
					l_list := a_class_list_list @ a_class_list.index
					l_list.start
					inspect
						selected_implementation
					when adds_suppliers then
						l_x := l_class_figure.x + l_class_figure.width + l_x_offset
						l_y := l_class_figure.y - ((l_list.count - 1) * ((l_y_offset + l_class_figure.height) // 2))
					when adds_clients then
						l_x := l_class_figure.x - l_class_figure.width - l_x_offset
						l_y := l_class_figure.y - ((l_list.count - 1) * ((l_y_offset + l_class_figure.height) // 2))
					when adds_ancestors then
						l_x := l_class_figure.x - ((l_list.count - 1) * ((l_x_offset + l_class_figure.width) // 2))
						l_y := l_class_figure.y - l_class_figure.height - l_y_offset
					when adds_descendents then
						l_x := l_class_figure.x - ((l_list.count - 1) * ((l_x_offset + l_class_figure.width) // 2))
						l_y := l_class_figure.y + l_class_figure.height + l_y_offset
					end
				until
					l_list.after
				loop
					l_list.item.enable_needed_on_diagram
					l_class_graph.add_client_relations (l_list.item)
					l_class_graph.add_supplier_relations (l_list.item)
					l_class_graph.add_descendant_relations (l_list.item)
					l_class_graph.add_ancestor_relations (l_list.item)
					l_supplier_class_figure ?= tool.world.figure_from_model (l_list.item)
					l_supplier_class_figure.set_x_y (l_x, l_y)
					inspect
						selected_implementation
					when adds_suppliers then
						l_y := l_y + l_y_offset + l_class_figure.height
					when adds_clients then
						l_y := l_y + l_y_offset + l_class_figure.height
					when adds_ancestors then
						l_x := l_x + l_x_offset + l_class_figure.width
					when adds_descendents then
						l_x := l_x + l_x_offset + l_class_figure.width
					end
					l_list.forth
				end
				a_class_list.forth
			end
			tool.projector.full_project
		end

	execute_with_class_stone (a_stone: CLASSI_STONE) is
			-- Handle pick and drop for `a_stone'.
		local
			a_class_list: ARRAYED_LIST [ES_CLASS]
			es_class: ES_CLASS
			cf: CLASSI_FIGURE_STONE
		do
			cf ?= a_stone
			if cf /= Void then
				es_class := cf.source.model
			end
			if es_class /= Void then
				if es_class.is_compiled then
					create a_class_list.make (1)
					a_class_list.extend (es_class)
					calculate_relations_for_classes (a_class_list)
				end
			end
		end

	execute_with_class_list (a_stone: CLASS_FIGURE_LIST_STONE) is
			-- Handle pick and drop for `a_stone'.
		local
			a_class_list: ARRAYED_LIST [ES_CLASS]
			l_classes: LIST [EIFFEL_CLASS_FIGURE]
			es_class: ES_CLASS
		do
			from
				l_classes := a_stone.classes
				l_classes.start
				create a_class_list.make (5)
			until
				l_classes.after
			loop
				es_class := l_classes.item.model
				if es_class.is_compiled then
					a_class_list.extend (es_class)
				end
				l_classes.forth
			end
			if not a_class_list.is_empty then
				calculate_relations_for_classes (a_class_list)
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
			Result.drop_actions.extend (agent execute_with_class_stone)
			Result.drop_actions.extend (agent execute_with_class_list)
		end

feature -- Access

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			inspect
				selected_implementation
			when adds_suppliers then
				Result := interface_names.l_diagram_add_suppliers
			when adds_clients then
				Result := interface_names.l_diagram_add_clients
			when adds_descendents then
				Result := interface_names.l_diagram_add_descendents
			when adds_ancestors then
				Result := interface_names.l_diagram_add_ancestors
			end
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			inspect
				selected_implementation
			when adds_suppliers then
				Result := pixmaps.icon_pixmaps.class_supliers_icon
			when adds_clients then
				Result := pixmaps.icon_pixmaps.class_clients_icon
			when adds_descendents then
				Result := pixmaps.icon_pixmaps.class_descendents_icon
			when adds_ancestors then
				Result := pixmaps.icon_pixmaps.class_ancestors_icon
			end
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			inspect
				selected_implementation
			when adds_suppliers then
				Result := pixmaps.icon_pixmaps.class_supliers_icon_buffer
			when adds_clients then
				Result := pixmaps.icon_pixmaps.class_clients_icon_buffer
			when adds_descendents then
				Result := pixmaps.icon_pixmaps.class_descendents_icon_buffer
			when adds_ancestors then
				Result := pixmaps.icon_pixmaps.class_ancestors_icon_buffer
			end
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			inspect
				selected_implementation
			when adds_suppliers then
				Result := interface_names.l_diagram_add_suppliers
			when adds_clients then
				Result := interface_names.l_diagram_add_clients
			when adds_descendents then
				Result := interface_names.l_diagram_add_descendents
			when adds_ancestors then
				Result := interface_names.l_diagram_add_ancestors
			end
		end

	menu_name: STRING_GENERAL is
			-- Name on corresponding menu items
		do
			Result := description
		end

	Name: STRING is "Supplier_visibility"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {ES_DIAGRAM_TOOL_PANEL} -- Implementation

	selected_implementation: INTEGER
		-- Implementation used for `Current', set in creation procedure.

	adds_clients: INTEGER is 1
	adds_suppliers: INTEGER is 2
	adds_descendents: INTEGER is 3
	adds_ancestors: INTEGER is 4;
		-- Constants used to define the behavior of `Current'.

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
end
