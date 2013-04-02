note
	description: "Common functionality for all views for ES_CLASSes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_CLASS_FIGURE

inherit
	EG_LINKABLE_FIGURE
		redefine
			initialize,
			model,
			default_create,
			add_link,
			world,
			on_handle_end,
			on_handle_start,
			recycle,
			xml_element,
			set_with_xml_element
		end

	EB_CONSTANTS
		undefine
			default_create
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create an CLASS_FIGURE
		do
			Precursor {EG_LINKABLE_FIGURE}
			set_pointer_style (default_pixmaps.sizeall_cursor)

			drop_actions.extend (agent on_class_drop)
			drop_actions.set_veto_pebble_function (agent veto_function)

			start_actions.extend (agent save_position)
			end_actions.extend (agent extend_history)
			move_actions.extend (agent on_move)

			pointer_double_press_actions.extend (agent on_pointer_double_pressed)
		end

	initialize
			-- Initialize a class figure with given model.
		do
			Precursor {EG_LINKABLE_FIGURE}

			pebble_function := agent on_pebble_request
			model.needed_on_diagram_changed_actions.extend (agent on_needed_on_diagram_changed)
		end

feature -- Access

	model: ES_CLASS
			-- Model for `Current'.

	world: EIFFEL_WORLD
			-- World `Current' is part of.
		do
			Result ?= Precursor {EG_LINKABLE_FIGURE}
		end

feature -- Element change

	recycle
			-- Free `Current's resources.
		do
			Precursor {EG_LINKABLE_FIGURE}
			drop_actions.prune_all (agent on_class_drop)
			start_actions.prune_all (agent save_position)
			end_actions.prune_all (agent extend_history)
			move_actions.prune_all (agent on_move)
			pointer_double_press_actions.prune_all (agent on_pointer_double_pressed)
			if model /= Void then
				model.needed_on_diagram_changed_actions.prune_all (agent on_needed_on_diagram_changed)
			end
		end

	apply_right_angles
			-- Apply right angles to all links in `links'.
		local
			l_item: EIFFEL_LINK_FIGURE
			l_links: like links
			i, nb: INTEGER
		do
			from
				l_links := links
				i := 1
				nb := l_links.count
			until
				i > nb
			loop
				l_item ?= l_links.i_th (i)
				if l_item /= Void then
					l_item.apply_right_angles
				end
				i := i + 1
			end
		end

feature -- XML

	id_string: STRING = "CLASS_FIGURE_ID"
			-- ID string

	group_id_string: STRING = "GROUP_ID"
			-- Group id

	xml_element (node: like xml_element): XML_ELEMENT
			-- XML element
		do
			Result := Precursor {EG_LINKABLE_FIGURE} (node)
			Result.add_attribute (id_string, xml_namespace, model.es_class_id)
			Result.add_attribute (group_id_string, xml_namespace, model.group_id)
		end

	set_with_xml_element (node: like xml_element)
			-- Retrive state from `node'.
		do
				-- Discard CLASS_FIGURE_ID and GROUP_ID, since they have been read in factory.
			node.forth
			node.forth
			Precursor {EG_LINKABLE_FIGURE} (node)
		end

feature {EG_FIGURE_WORLD} -- Element change

	add_link (a_link: EG_LINK_FIGURE)
			-- Add `a_link' to `links'.
		local
			l_cluster: EG_CLUSTER_FIGURE
			cs_link: EIFFEL_CLIENT_SUPPLIER_FIGURE
			i_link: EIFFEL_INHERITANCE_FIGURE
			c_fig: EG_LINKABLE_FIGURE
		do
			Precursor {EG_LINKABLE_FIGURE} (a_link)
			if a_link.source /= Void and then a_link.target /= Void then
				if a_link.source.cluster /= Void and then a_link.target.cluster /= Void then
					if a_link.model.source.cluster = a_link.model.target.cluster then
						l_cluster := a_link.source.cluster
					elseif a_link.model.source.cluster.has_recursive (a_link.model.target) then
						l_cluster := a_link.source.cluster
					elseif a_link.model.target.cluster.has_recursive (a_link.model.source) then
						l_cluster := a_link.target.cluster
					end
					if l_cluster /= Void then
						l_cluster.go_i_th (l_cluster.number_of_figures)
						cs_link ?= a_link
						if cs_link /= Void or else l_cluster.index = l_cluster.count then
							l_cluster.put_right (a_link)
						else
							from
							until
								i_link /= Void or else c_fig /= Void
							loop
								l_cluster.forth
								i_link ?= l_cluster.item
								c_fig ?= l_cluster.item
							end
							l_cluster.put_left (a_link)
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	on_needed_on_diagram_changed
			-- `model'.`is_needed_on_diagram' changed.
		do
			if model.is_needed_on_diagram then
				show
				enable_sensitive
			else
				hide
				disable_sensitive
			end
			request_update
		end

	on_pebble_request: ANY
			-- A pebble was requested for `Current'.
		local
			class_list: ARRAYED_LIST [EIFFEL_CLASS_FIGURE]
			cf: EIFFEL_CLASS_FIGURE
			l_selected: LIST [EG_FIGURE]
		do
			if not workbench.is_compiling then
				if world.selected_figures.count < 2 or else not world.selected_figures.has (Current) then
					if model.is_compiled then
						create {CLASSC_FIGURE_STONE} Result.make (Current)
					else
						create {CLASSI_FIGURE_STONE} Result.make (Current)
					end
					set_accept_cursor (Cursors.cur_Class)
					set_deny_cursor (Cursors.cur_X_class)
				else
					l_selected := world.selected_figures
					create class_list.make (l_selected.count)
					from
						l_selected.start
					until
						l_selected.after
					loop
						cf ?= l_selected.item
						if cf /= Void then
							class_list.extend (cf)
						end
						l_selected.forth
					end
					create {CLASS_FIGURE_LIST_STONE} Result.make_with_list (class_list)
					set_accept_cursor (cursors.cur_class_list)
					set_deny_cursor (cursors.cur_x_class_list)
				end
			end
		end

	on_pointer_double_pressed (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
			-- User double pressed on `Current'.
		local
			cg: ES_CLASS_GRAPH
			old_center: EG_LINKABLE_FIGURE
			old_es_center: ES_CLASS
			fdl: EG_FORCE_DIRECTED_LAYOUT
			ce: ES_DIAGRAM_TOOL_PANEL
			new_classes: LIST [ES_CLASS]
			layout: EIFFEL_INHERITANCE_LAYOUT
			l_shift_pressed: BOOLEAN
			l_editor: EB_SMART_EDITOR
		do
			if button = 1 then
				l_shift_pressed := ev_application.shift_pressed
				ce := world.context_editor
				cg := ce.class_graph
				if cg /= Void and then l_shift_pressed then
					old_es_center := cg.center_class
					old_center ?= world.figure_from_model (old_es_center)
					check
						old_center_exists: old_center /= Void
					end
					old_center.set_is_fixed (False)
					cg.set_new_center_class (model)

					new_classes := cg.last_created_classes
					cg.reset_last_created_classes

					if ce.is_force_directed_used then
						arrange_around (new_classes, port_x, port_y, 200)
						fdl := ce.force_directed_layout
						ce.restart_force_directed
						fdl.set_center (port_x, port_y)
						set_is_fixed (True)
						if not world.context_editor.history.undo_list.is_empty then
							world.context_editor.history.remove_last
						end
						world.context_editor.history.register_named_undoable (
						interface_names.t_diagram_set_center_class (model.name),
						[<<
							agent old_center.set_is_fixed (False),
							agent cg.set_new_center_class (model),
							agent set_is_fixed (True),
							agent fdl.set_center (port_x, port_y),
							agent ce.restart_force_directed,
							agent world.update_cluster_legend
						>>],
						[<<
							agent set_is_fixed (False),
							agent cg.set_new_center_class (old_es_center),
							agent old_center.set_is_fixed (True),
							agent fdl.set_center (old_center.port_x, old_center.port_y),
							agent ce.restart_force_directed,
							agent world.update_cluster_legend
						>>])
					else
						create layout.make_with_world (world)
						if world.is_uml then
							layout.set_spacing ({ES_DIAGRAM_TOOL_PANEL}.default_uml_horizontal_spacing, {ES_DIAGRAM_TOOL_PANEL}.default_uml_vertical_spacing)
						else
							layout.set_spacing ({ES_DIAGRAM_TOOL_PANEL}.default_bon_horizontal_spacing, {ES_DIAGRAM_TOOL_PANEL}.default_bon_vertical_spacing)
						end
						layout.layout
						if not world.context_editor.history.undo_list.is_empty then
							world.context_editor.history.remove_last
						end
						world.context_editor.history.register_named_undoable (
						interface_names.t_diagram_set_center_class (model.name),
						[<<
							agent cg.set_new_center_class (model),
							agent layout.layout,
							agent world.update_cluster_legend
						>>],
						[<<
							agent cg.set_new_center_class (old_es_center),
							agent layout.layout,
							agent world.update_cluster_legend
						>>])
					end
					world.update_cluster_legend
					world.context_editor.develop_window.tools.set_stone (create {CLASSI_STONE}.make (model.class_i))
				elseif l_shift_pressed then
					world.context_editor.develop_window.tools.set_stone (create {CLASSI_STONE}.make (model.class_i))
				else
						-- Attempt to open `Current' in an available editor.
					l_editor := world.context_editor.develop_window.editors_manager.editor_with_stone (create {CLASSI_STONE}.make (model.class_i))
					if l_editor = Void then
						world.context_editor.develop_window.editors_manager.create_editor
					end
					world.context_editor.develop_window.advanced_set_stone (create {CLASSI_STONE}.make (model.class_i))
				end
			end
		end

	arrange_around (classes: LIST [ES_CLASS]; ax,ay: INTEGER; radius: INTEGER)
			-- Arrange classes on a circle with center at (`ax', `ay') and `radius'.
		local
			nb: INTEGER
			l_angle, angle_inc: DOUBLE
			cf: EIFFEL_CLASS_FIGURE
		do
			nb := classes.count
			l_angle := 0.0
			angle_inc := 2*pi / nb
			from
				classes.start
			until
				classes.after
			loop
				cf ?= world.figure_from_model (classes.item)
				if cf /= Void then
					cf.set_port_position (port_x + as_integer (cosine (l_angle) * radius), port_y + as_integer (sine (l_angle) * radius))
				end
				classes.forth
				l_angle := l_angle + angle_inc
			end
		end

feature {NONE} -- Implementation (adding relations)

	on_class_drop (a_stone: CLASSI_FIGURE_STONE)
			-- `a_stone' was dropped on `Current'.
		local
			class_file: PLAIN_TEXT_FILE
		do
			create class_file.make_with_path (a_stone.class_i.file_name)
			if not class_file.exists then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (
					interface_names.l_class_is_not_editable.as_string_32 + warning_messages.w_file_not_exist (class_file.path.name),
					world.context_editor.develop_window.window, Void)
			elseif class_file.is_writable and then not a_stone.class_i.group.is_readonly then
				if world.context_editor.is_link_client then
					add_client_relation (a_stone.source)
				else
						-- We are adding an inheritance link.
					if drop_allowed (a_stone) then
						add_inheritance_relation (a_stone.source)
					else
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
							interface_names.l_inheritance_cycle_was_created, world.context_editor.develop_window.window, agent add_inheritance_relation (a_stone.source), Void)
					end
				end
			else
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (
					interface_names.l_class_is_not_editable, world.context_editor.develop_window.window, Void)
			end
		end

	add_inheritance_relation (other: EIFFEL_CLASS_FIGURE)
			-- Add `Current' to others inheritance clause.
		local
			es_link: ES_INHERITANCE_LINK
			other_model: ES_CLASS
			screen: EV_SCREEN
			x_pos, y_pos, screen_w, screen_h: INTEGER
			cg: CLASS_TEXT_MODIFIER
			added_code: LIST [TUPLE [STRING_8, INTEGER]]
			l_is_non_conforming: BOOLEAN
		do
			if world.model.has_node (other.model) then
				other_model := other.model
				-- Call wizard.
				create screen
				screen_w := screen.virtual_right
				screen_h := screen.virtual_bottom
				x_pos := (port_x + other.port_x) // 2 + world.context_editor.widget.screen_x - world.bounding_box.x
				y_pos := (port_y + other.port_y) // 2 + world.context_editor.widget.screen_y - world.bounding_box.y

				cg := other_model.code_generator
				cg.new_parent_from_diagram (other_model, model, x_pos, y_pos, screen_w, screen_h)
				if cg.extend_from_diagram_successful and then not cg.class_modified_outside_diagram then
					added_code := cg.last_added_code.twin
					l_is_non_conforming := cg.new_parent_non_conforming
					es_link ?= model.graph.inheritance_link_connecting (other_model, model, l_is_non_conforming)
					if es_link = Void then
						create es_link.make (other_model, model, False)
						es_link.set_is_non_conforming (l_is_non_conforming)
						model.graph.add_link (es_link)
					elseif not es_link.is_needed_on_diagram then
						es_link.enable_needed_on_diagram
					end
					world.context_editor.history.register_named_undoable (
						interface_names.t_diagram_add_inh_link_cmd (es_link.ancestor.name, es_link.descendant.name, l_is_non_conforming),
						agent add_ancestor (other_model, es_link, l_is_non_conforming),
						agent remove_ancestor (other_model, es_link, l_is_non_conforming))
				end
			end
		end

	add_ancestor (an_other: like model; a_link: ES_INHERITANCE_LINK; is_non_conforming: BOOLEAN)
			-- Add `Current' to `an_other's inheritance clause, show `a_link' if successful.
		do
			an_other.code_generator.add_ancestor (model.class_i.name, is_non_conforming)
			if not an_other.code_generator.class_modified_outside_diagram then
				a_link.enable_needed_on_diagram
			end
		end

	remove_ancestor (an_other: like model; a_link: ES_INHERITANCE_LINK; is_non_conforming: BOOLEAN)
			-- Remove `Current' from `an_other's inheritance clause, hide `a_link' if successful.
		do
			an_other.code_generator.remove_ancestor (model.class_i.name, is_non_conforming)
			if not an_other.code_generator.class_modified_outside_diagram then
				a_link.disable_needed_on_diagram
			end
		end

	add_client_relation (client: EIFFEL_CLASS_FIGURE)
			-- Add relation with `Current' as supplier and `client' as client
		require
			client_not_void: client /= Void
		local
			screen: EV_SCREEN
			x_pos, y_pos, screen_w, screen_h: INTEGER
			cg: CLASS_TEXT_MODIFIER
			added_code: LIST [TUPLE [STRING_8, INTEGER]]
			es_link: ES_CLIENT_SUPPLIER_LINK
			last_query: FEATURE_AS
			client_model: ES_CLASS
		do
			if world.model.has_node (client.model) then
				-- Call wizard.
				create screen
				screen_w := screen.virtual_right
				screen_h := screen.virtual_bottom
				x_pos := (port_x + client.port_x) // 2 + world.context_editor.widget.screen_x - world.bounding_box.x
				y_pos := (port_y + client.port_y) // 2 + world.context_editor.widget.screen_y - world.bounding_box.y
				client_model := client.model
				cg := client_model.code_generator
				cg.new_feature_from_diagram (client_model, model, x_pos, y_pos, screen_w, screen_h, False)--client /= Current)

					-- Reflect new added code in diagram if any is added.
				last_query := cg.last_feature_as
				if cg.extend_from_diagram_successful and then last_query /= Void then
					added_code := cg.last_added_code.twin
					if last_query.body.type /= Void then
							-- We have a query as the body has a return type.
						client_model.add_query (last_query)
						es_link ?= model.graph.client_supplier_link_connecting (client_model, model)
						if es_link = Void or else not es_link.is_needed_on_diagram then
							if es_link = Void then
								create es_link.make (client_model, model)
								model.graph.add_link (es_link)
							else
								es_link.enable_needed_on_diagram
								es_link.synchronize
							end

							world.context_editor.history.register_named_undoable (
								interface_names.t_diagram_add_cs_link_cmd (es_link.client.name, es_link.supplier.name),
								agent reinclude_removed_feature_and_link (client_model, added_code, last_query, es_link),
								agent remove_added_feature_and_link (client_model, added_code, last_query, es_link))
						else
							es_link.synchronize
							world.context_editor.history.register_named_undoable (
								interface_names.t_diagram_add_cs_link_cmd (es_link.client.name, es_link.supplier.name),
								agent reinclude_removed_feature_and_link (client_model, added_code, last_query, es_link),
								agent remove_added_feature (client_model, added_code, last_query, es_link))
						end
					else
							-- We are adding a procedure via the diagram tool so no link is needed
						world.context_editor.history.register_named_undoable (
							interface_names.t_diagram_add_cs_link_cmd (client_model.name, model.name),
							agent reinclude_added_code (model, added_code),
							agent remove_added_code (model, added_code))

					end
				end
			end
		end

	reinclude_removed_feature_and_link (a_client: ES_CLASS; added_code: LIST [TUPLE [STRING_8, INTEGER]]; added_feature: FEATURE_AS; a_link: ES_CLIENT_SUPPLIER_LINK)
			-- Reinclude code in `a_client' with associating `a_link'.
		do
			reinclude_added_code (a_client, added_code)
			if not a_client.code_generator.class_modified_outside_diagram then
				a_client.add_query (added_feature)
				a_link.enable_needed_on_diagram
				a_link.synchronize
			end
		end

	remove_added_feature_and_link (a_client: ES_CLASS; added_code: LIST [TUPLE [STRING_8, INTEGER]]; added_feature: FEATURE_AS; a_link: ES_CLIENT_SUPPLIER_LINK)
			-- Remove code from `a_client' represented by `a_link'.
		do
			a_client.code_generator.delete_code (added_code)
			if not a_client.code_generator.class_modified_outside_diagram then
				a_client.remove_query (added_feature)
				a_link.disable_needed_on_diagram
			end
		end

	remove_added_feature (a_client: ES_CLASS; added_code: LIST [TUPLE [STRING_8, INTEGER]]; added_feature: FEATURE_AS; a_link: ES_CLIENT_SUPPLIER_LINK)
			-- Remove added code from `a_client'
		do
			remove_added_code (a_client, added_code)
			if not a_client.code_generator.class_modified_outside_diagram then
				a_client.remove_query (added_feature)
				a_link.synchronize
			end
		end

	remove_added_code (a_client: ES_CLASS; added_code: LIST [TUPLE [STRING_8, INTEGER]])
			-- Remove code represented by `added_code' from `a_client'
		do
			a_client.code_generator.delete_code (added_code)
		end

	reinclude_added_code (a_client: ES_CLASS; added_code: LIST [TUPLE [STRING_8, INTEGER]])
			-- Readd the code represented by `added_code' to `a_client'.
		do
			a_client.code_generator.undelete_code (added_code)
		end

	drop_allowed (a_stone: CLASSI_FIGURE_STONE): BOOLEAN
			-- Is `a_stone' droppable on `Current'?
		local
			new_child: CLASS_I
		do
			if not world.context_editor.is_link_client then
				new_child := a_stone.class_i
				if new_child.is_compiled and model.class_i.is_compiled then
					Result := not model.class_i.compiled_class.inherits_from (new_child.compiled_class)
				else
					Result := not model.class_i.name.is_equal ("ANY")
				end
			else
				Result := True
			end
		end

feature {NONE} -- Implementation (move)

	veto_function (a_any: ANY): BOOLEAN
			-- Veto function
		require
			a_any_not_void: a_any /= Void
		local
			l_class_fig_stone: CLASSI_FIGURE_STONE
			l_world: EIFFEL_CLUSTER_DIAGRAM
		do
			if model /= Void then --and then not model.class_i.is_read_only then
				l_class_fig_stone ?= a_any
				if l_class_fig_stone /= Void then
					Result := True
					l_world ?= world
					if l_world /= Void and then attached {CONF_CLASS} model.class_i as l_conf_class then
						if not l_class_fig_stone.group.is_valid or else not l_class_fig_stone.group.accessible_classes.has_item (l_conf_class) then
							Result := False
						end
					end
				end
			end
		end

	save_position
			-- Make a backup of current coordinates.
		do
			saved_x := port_x
			saved_y := port_y
		end

	saved_x, saved_y: INTEGER
			-- Saved positions.

	extend_history
			-- Register move in the history.
		local
			offset_x, offset_y: INTEGER
			l_selected_figures: LIST [EG_FIGURE]
		do
			l_selected_figures := world.selected_figures.twin
			offset_x := port_x - saved_x
			offset_y := port_y - saved_y
			world.context_editor.history.register_named_undoable (
				interface_names.t_diagram_move_class_cmd (model.name),
				agent move_figures_for (l_selected_figures, offset_x, offset_y),
				agent move_figures_for (l_selected_figures, -offset_x, -offset_y))
			if world.context_editor.is_force_directed_used then
				set_is_fixed (True)
			end
		end

	move_figures_for (figures: LIST [EG_FIGURE]; ax, ay: INTEGER)
			-- Move all figures in `figures' for `ax', `ay'.
		require
			figures_not_void: figures /= Void
		local
			l_item: EG_FIGURE
			l_linkable: EG_LINKABLE_FIGURE
			l_class: EIFFEL_CLASS_FIGURE
		do
			from
				figures.start
			until
				figures.after
			loop
				l_item := figures.item
				l_item.set_point_position (l_item.point_x + ax, l_item.point_y + ay)
				l_linkable ?= l_item
				if l_linkable /= Void then
					l_linkable.set_is_fixed (True)
				end
				l_class ?= l_item
				figures.forth
			end
			if world.is_right_angles then
				world.apply_right_angles
			end
			world.context_editor.restart_force_directed
		end

	on_move (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
		do
			if world.context_editor.is_force_directed_used then
				-- FIXME: The timer event should be fired even when `Current' is moved.
				world.context_editor.on_time_out
			end
			world.context_editor.restart_force_directed
			if
				world.context_editor.class_graph /= Void and then
				model = world.context_editor.class_graph.center_class
			then
				world.context_editor.force_directed_layout.set_center (port_x, port_y)
			end
		end

	on_handle_start
			-- User started to move `Current'.
		do
			was_fixed := is_fixed
			if world.context_editor.is_force_directed_used then
				set_is_fixed (True)
			end
		end

	on_handle_end
			-- User ended to move `Current'.
		do
			set_is_fixed (was_fixed)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class EIFFEL_CLASS_FIGURE
