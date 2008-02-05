indexing
	description: "Objects that represent the data of a objects grid row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_SPECIFIC_LINE

inherit

	ES_OBJECTS_GRID_SPECIFIC_LINE_CONSTANTS

	ES_OBJECTS_GRID_LINE
		redefine
			record_layout,
			reset
		end

create
	make_as_locals,
	make_as_arguments,
	make_as_result,
	make_as_current_object,
	make_as_stack

feature {NONE} -- Initialization

	make_as (a_id: INTEGER) is
			-- Initialize `Current'.
		do
			written_line := Current
			make
			id := a_id
			display_expanded := True
			set_read_only (True)
		end

	make_as_stack is
		do
			make_as (stack_id)
		end

	make_as_arguments is
		do
			make_as (arguments_id)
		end

	make_as_locals is
		do
			make_as (locals_id)
		end

	make_as_result is
		do
			make_as (result_id)
		end

	make_as_current_object is
		do
			make_as (current_object_id)
		end

feature -- Status

	display_expanded: BOOLEAN

feature -- Access

	id: INTEGER

	is_represented_by (aline: ES_OBJECTS_GRID_LINE): BOOLEAN is
		do
			Result := (aline = written_line)
		end

	written_line: ES_OBJECTS_GRID_LINE

feature -- Change

	set_display_expanded (b: BOOLEAN) is
			-- Set `display_expanded' with `b'
		do
			display_expanded := b
		end

	update is
		do
		end

	compute_grid_display is
		local
			cse: like call_stack_element
		do
			if row /= Void and not compute_grid_display_done then
				cse := call_stack_element
				inspect
					id
				when arguments_id then
					compute_grid_display_for_arguments (cse)
				when locals_id then
					compute_grid_display_for_locals (cse)
				when result_id then
					compute_grid_display_for_result (cse)
				when current_object_id then
					compute_grid_display_for_current_object (cse)
				when stack_id then
					compute_grid_display_for_stack (cse)
				else
					check should_not_occurs: False end
				end

				set_expand_action   (agent (r: EV_GRID_ROW) do display_expanded := True  end)
				set_collapse_action (agent (r: EV_GRID_ROW) do display_expanded := False end)

				compute_grid_display_done := True
				if
					display_expanded
					and
					row /= Void and then row.is_expandable
				then
					row.expand
				end
				update
			end
		end

	record_layout is
		do
			Precursor
			if
				written_line /= Void
				and then written_line /= Current
				and then written_line.row /= Void
				and then written_line.row.parent /= Void
				and then written_line.row.is_show_requested
				and then written_line.compute_grid_display_done
			then
				display_expanded := written_line.row.is_expanded
			elseif
				row /= Void
				and then row.parent /= Void
				and then row.is_show_requested
				and then compute_grid_display_done
			then
				display_expanded := row.is_expanded
			end
		end

	reset is
			--
		do
			Precursor
			reset_compute_grid_display_done
			if written_line /= Void and written_line /= Current then
				written_line.reset
				written_line := Void
			end
		end


feature {NONE} -- Implementation

	call_stack_element: EIFFEL_CALL_STACK_ELEMENT is
			--
		local
			app: APPLICATION_EXECUTION
		do
			if debugger_manager.safe_application_is_stopped then
				app := debugger_manager.application
				if
					not app.current_call_stack_is_empty
				then
					check app.status.current_call_stack /= Void end
					Result ?= app.status.current_call_stack_element
				end
			end
		end

	compute_grid_display_for_arguments (cse: like call_stack_element) is
		local
			glab: EV_GRID_LABEL_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
			r: INTEGER
		do
			if cse /= Void then
				list := cse.arguments
			end
			if list /= Void and then not list.is_empty then
				glab := parent_grid.folder_label_item (Interface_names.l_Arguments)
				parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.folder_features_all_icon)
				row.set_item (1, glab)
				from
					row.insert_subrows (list.count, 1)
					r := row.index + 1
					list.start
				until
					list.after
				loop
					parent_grid.attach_debug_value_to_grid_row (parent_grid.row (r), list.item, Void)
					r := r + 1
					list.forth
				end
				row.show
				row.ensure_expandable
			else
				row.hide
			end
		end

	compute_grid_display_for_locals (cse: like call_stack_element) is
		local
			i: INTEGER
			glab: EV_GRID_LABEL_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
			tmp: SORTABLE_ARRAY [ABSTRACT_DEBUG_VALUE]
			dbg_nb: INTEGER
			r: INTEGER
		do
			if cse /= Void then
				list := cse.locals
			end
			if list /= Void and then not list.is_empty then
				glab := parent_grid.folder_label_item (Interface_names.l_Locals)
				parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.folder_features_all_icon)
				row.set_item (1, glab)
				dbg_nb := list.count
				create tmp.make (1, dbg_nb)
				from
					list.start
					i := 1
				until
					list.after
				loop
					tmp.put (list.item, i)
					i := i + 1
					list.forth
				end
				tmp.sort
				from
					row.insert_subrows (dbg_nb, 1)
					r := row.index + 1
					i := 1
				until
					i > dbg_nb
				loop
					parent_grid.attach_debug_value_to_grid_row (parent_grid.row (r), tmp @ i, Void)
					r := r + 1
					i := i + 1
				end
				row.show
				row.ensure_expandable
			else
				row.hide
			end
		end

	compute_grid_display_for_result (cse: like call_stack_element) is
		local
			dv: ABSTRACT_DEBUG_VALUE
			glab: EV_GRID_LABEL_ITEM
			r: INTEGER
		do
			if cse /= Void and then cse.has_result then
				glab := parent_grid.folder_label_item (Interface_names.l_result)
				parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.folder_features_all_icon)
				row.set_item (1, glab)
				dv := cse.result_value
				row.show
				if dv /= Void then
					row.insert_subrows (1, 1)
					r := row.index + 1
					parent_grid.attach_debug_value_to_grid_row (parent_grid.row (r), dv, Void)
					row.ensure_expandable
				end
			else
				row.hide
			end
		end

	compute_grid_display_for_current_object (cse: like call_stack_element) is
		local
			value: ABSTRACT_DEBUG_VALUE
			proc: PROCEDURE [ANY, TUPLE]
			item: ES_OBJECTS_GRID_OBJECT_LINE
			dn_st: APPLICATION_STATUS_DOTNET
			app: APPLICATION_EXECUTION
			r: like row
		do
			if cse /= Void then
				if debugger_manager.is_dotnet_project then
					app := debugger_manager.application
					if not app.current_call_stack_is_empty then
						dn_st ?= app.status
						check dn_st /= Void end
						value := dn_st.current_call_stack_element_dotnet.current_object
						if value /= Void then
							create {ES_OBJECTS_GRID_VALUE_LINE} item.make_with_value (value, parent_grid)
						end
					end
				else
					create {ES_OBJECTS_GRID_ADDRESS_LINE} item.make_with_call_stack_element (cse, parent_grid)
				end
			end
			if item /= Void then
				item.set_read_only (is_read_only)
				written_line := item --| Override default written_line
				item.set_display (display_expanded)
				item.set_title (interface_names.l_current_object)
				r := row
				if
					compute_grid_row_completed_action /= Void
					and then compute_grid_row_completed_action.is_empty
				then
					from
						compute_grid_row_completed_action.start
					until
						compute_grid_row_completed_action.after
					loop
						proc := compute_grid_row_completed_action.item
						if compute_grid_row_completed_action.has_kamikaze_action (proc) then
							item.compute_grid_row_completed_action.extend_kamikaze (proc)
						else
							item.compute_grid_row_completed_action.extend (proc)
						end
						compute_grid_row_completed_action.remove
					end
					check
						compute_grid_row_completed_action.count = 0
					end
				end
				unattach
				item.attach_to_row (r)
			else
				row.hide
			end
		end

	compute_grid_display_for_stack (cse: like call_stack_element) is
		local
			r: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			es_glab: EV_GRID_LABEL_ITEM
			l_exception_class_detail: STRING
			l_exception_module_detail: STRING_32
			l_exception_meaning, l_exception_message, l_exception_text: STRING_32
			appstat: APPLICATION_STATUS
			dotnet_status: APPLICATION_STATUS_DOTNET
			exc_dv: EXCEPTION_DEBUG_VALUE
		do
			appstat := debugger_manager.application_status
			if appstat.exception_occurred then
					--| Details
				glab := parent_grid.folder_label_item (Cst_exception_raised_text)
				parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.debug_exception_handling_icon)
				row.set_item (1, glab)
				create glab

				dotnet_status ?= appstat
				if dotnet_status /= Void then
					if dotnet_status.exception_handled then
						parent_grid.grid_cell_set_text (glab, Cst_exception_first_chance_text)
					else
						parent_grid.grid_cell_set_text (glab, Cst_exception_unhandled_text)
					end
				else
					parent_grid.grid_cell_set_text (glab, appstat.exception_short_description)
				end
				row.set_item (2, glab)

				exc_dv := appstat.exception
				if exc_dv /= Void then
						--| Meaning
					l_exception_meaning := exc_dv.meaning
					if l_exception_meaning /= Void then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Meaning")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_meaning)
						parent_grid.grid_cell_set_text (es_glab, l_exception_meaning)
						r.set_item (2, es_glab)
					end
						--| Message
					l_exception_message := exc_dv.message
					if l_exception_message /= Void then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Message")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_message)
						parent_grid.grid_cell_set_text (es_glab, l_exception_message)
						r.set_item (2, es_glab)
					end

						--| Class
					l_exception_class_detail := exc_dv.type_name
					if l_exception_class_detail /= Void then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item ("Type")
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_class_detail)
						parent_grid.grid_cell_set_text (es_glab, l_exception_class_detail)
						r.set_item (2, es_glab)
					end

					if dotnet_status /= Void then
							--| IL type name
						l_exception_class_detail := dotnet_status.exception_il_type_name
						if l_exception_class_detail /= Void then
							r := parent_grid.extended_new_subrow (row)
							glab := parent_grid.name_label_item ("IL Type")
							parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
							r.set_item (1, glab)
							create es_glab
							es_glab.set_data (l_exception_class_detail)
							parent_grid.grid_cell_set_text (es_glab, l_exception_class_detail)
							r.set_item (2, es_glab)
						end
							--| Module
						l_exception_module_detail := dotnet_status.exception_module_name
						if l_exception_module_detail /= Void then
							r := parent_grid.extended_new_subrow (row)
							glab := parent_grid.name_label_item (interface_names.l_module)
							parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
							r.set_item (1, glab)
							create es_glab
							es_glab.set_data (l_exception_module_detail)
							parent_grid.grid_cell_set_text (es_glab, l_exception_module_detail)
							r.set_item (2, es_glab)
						end
					end

						--| Nota/Message
					l_exception_text := exc_dv.text
					if l_exception_text /= Void and then not l_exception_text.is_empty then
						r := parent_grid.extended_new_subrow (row)
						glab := parent_grid.name_label_item (interface_names.l_note)
						parent_grid.grid_cell_set_pixmap (glab, pixmaps.icon_pixmaps.general_mini_error_icon)
						r.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_text)
						parent_grid.grid_cell_set_text (es_glab, cst_exception_double_click_text)
						parent_grid.grid_cell_set_tooltip (es_glab, l_exception_text)
						es_glab.pointer_double_press_actions.force_extend (agent show_exception_dialog (exc_dv))
						r.set_item (2, es_glab)
					end

					r := parent_grid.extended_new_subrow (row)
					parent_grid.attach_debug_value_to_grid_row (r, exc_dv, interface_names.l_exception_object)
				end
				row.show
				row.ensure_expandable
			else
				row.hide
			end
		end

	show_exception_dialog (a_exc_dv: EXCEPTION_DEBUG_VALUE) is
			-- Show `a_exc_dv' in exception dialog
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
		do
			create dlg.make
			dlg.set_exception (a_exc_dv)
			dlg.set_is_modal (True)
			dlg.show_on_active_window
		end

	Cst_exception_double_click_text: STRING_GENERAL is
		do
			Result := interface_names.l_exception_double_click_text
		end

	Cst_exception_raised_text: STRING_GENERAL is
		do
			Result := interface_names.l_exception_raised
		end

	Cst_exception_first_chance_text: STRING_GENERAL is
		do
			Result := interface_names.l_first_chance
		end

	Cst_exception_unhandled_text: STRING_GENERAL is
		do
			Result := interface_names.l_unhandled
		end

feature -- Query

	debug_output: STRING is
		do
			inspect
				id
			when arguments_id then
				Result := "Arguments"
			when locals_id then
				Result := "Locals"
			when result_id then
				Result := "Result"
			when current_object_id then
				Result := "Current Object"
			when stack_id then
				Result := "Stack Info"
			else
				Result := "..."
			end
		end

	text_data_for_clipboard: STRING_32 is
		do
			Result := Void
		end

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
