note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_VALUE_LINE

inherit

	ES_OBJECTS_GRID_OBJECT_LINE
		rename
			data as object,
			set_data as set_object
		redefine
			object,
			reset_special_attributes_values,
			reset,
			get_items_stone_properties
		end

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

create
	make_with_value

feature {NONE}

	make_with_value (dv: ABSTRACT_DEBUG_VALUE; g: like parent_grid)
		require
			dv /= Void
		do
			create object_spec_count_and_capacity
			make_with_grid (g)
			if attached {ABSTRACT_REFERENCE_VALUE} dv as conv_abs_ref then
				object_address := conv_abs_ref.address
			elseif attached {ABSTRACT_SPECIAL_VALUE} dv as conv_abs_spec then
				object_address := conv_abs_spec.address
				object_is_special_value := True
				object_spec_count_and_capacity.spec_count := conv_abs_spec.count
				object_spec_count_and_capacity.spec_capacity := conv_abs_spec.capacity
			else
				object_address := Void -- "Unknown address"
			end
			set_object (dv)
		end

feature -- Recycling

	reset
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
			object := Void
		end

feature -- Properties

	object: ABSTRACT_DEBUG_VALUE

	object_name: STRING_32
		do
			Result := object.name
		end

	object_address: DBG_ADDRESS
			-- <Precursor>

	object_dynamic_class: CLASS_C
		do
			Result := object.dynamic_class
			if Result = Void then
				Result := object.static_class
			end
		end

	object_spec_count_and_capacity: TUPLE [spec_count, spec_capacity: INTEGER]

feature {NONE} -- Object stone

	get_items_stone_properties
		local
			cl: detachable CLASS_C
			fst: FEATURE_STONE
			fost: FEATURE_ON_OBJECT_STONE
			feat: E_FEATURE
			t: like internal_item_stone_data_i_th
		do
			Precursor
			if attached {ES_OBJECTS_GRID_OBJECT_LINE} related_line as l_rel_obj_line then
				if attached object_name as ostn then
					cl := l_rel_obj_line.object_dynamic_class
					if cl /= Void then
						feat := cl.feature_with_name (ostn)
						if feat /= Void then
								--| Note: `l_rel_obj_line.object_address' can be Void
							create fost.make (l_rel_obj_line.object_address, feat)
							t := internal_item_stone_data_i_th (0)
							if t /= Void then
								if attached {OBJECT_STONE} t.pebble as objst then
									fost.attach_object_stone (objst)
								end
							end
							fst := fost

							create t
							t.pebble := fst
							t.accept_cursor := fst.stone_cursor
							t.deny_cursor := fst.X_stone_cursor
							internal_items_stone_data[col_name_index] := t
							if internal_items_stone_data [0] = Void then
								internal_items_stone_data [0] := t
							end
						else
							-- TODO: look for local variable!
						end
					end
				end
			elseif attached {ES_OBJECTS_GRID_LOCALS_LINE} related_line as l_rel_loc_line then
				if
					attached object_name as ostn and then
					attached l_rel_loc_line.local_ast_stone (ostn) as l_ast_st
				then
					create t
					t.pebble := l_ast_st
					t.accept_cursor := l_ast_st.stone_cursor
					t.deny_cursor := l_ast_st.X_stone_cursor
					internal_items_stone_data[col_name_index] := t
					if internal_items_stone_data [0] = Void then
						internal_items_stone_data [0] := t
					end
				end
			elseif attached {ES_OBJECTS_GRID_ARGUMENTS_LINE} related_line as l_rel_arg_line then
				if
					attached object_name as ostn and then
					attached l_rel_arg_line.argument_ast_stone (ostn) as l_ast_st
				then
					create t
					t.pebble := l_ast_st
					t.accept_cursor := l_ast_st.stone_cursor
					t.deny_cursor := l_ast_st.X_stone_cursor
					internal_items_stone_data[col_name_index] := t
					if internal_items_stone_data [0] = Void then
						internal_items_stone_data [0] := t
					end
				end
			end
		end

feature -- Related line if precised

	set_related_line (v: like related_line)
		do
			related_line := v
		end

	related_line: ES_OBJECTS_GRID_LINE

feature -- Query

	has_attributes_values: BOOLEAN
		do
			Result := object.expandable
		end

	reset_special_attributes_values
		do
			if attached {ABSTRACT_SPECIAL_VALUE} object as spec_items then
				spec_items.reset_items
				spec_items.set_sp_bounds (object_spec_lower, object_spec_upper)
			end
		end

	sorted_attributes_values: DEBUG_VALUE_LIST
		do
			Result := object.sorted_children
		end

	sorted_once_routines: LIST [E_FEATURE]
		do
			if attached object_dynamic_class as l_class then
				Result := l_class.once_routines
			else
				--| Q: Why do we have Void dynamic_class ?
				--| ANSWER : because of external class in dotnet system
				--| Should be fixed now by using SYSTEM_OBJECT for unknown type
			end
		end

	sorted_constant_features: LIST [E_CONSTANT]
		do
			if attached object_dynamic_class as l_class then
				Result := l_class.constant_features
			else
				--| Q: Why do we have Void dynamic_class ?
			end
		end

	associated_dump_value: DUMP_VALUE
		do
			Result := internal_associated_dump_value
			if Result = Void then
				Result := object.dump_value
				internal_associated_dump_value := Result
			end
		end

	internal_associated_dump_value: like associated_dump_value

feature -- Graphical changes

	compute_grid_display
		local
			dv: detachable ABSTRACT_DEBUG_VALUE
			gi: detachable EV_GRID_ITEM
		do
			if row /= Void and not compute_grid_display_done then
				compute_grid_display_done := True
				dv := object
				if dv = Void then
					last_dump_value := Void
					set_name (debugger_names.l_no_object)
					set_value (Void)
					set_type (Void)
					set_address (Void)
					set_scoop_pid_value (0)
					set_pixmap (Icons [{VALUE_TYPES}.Void_value])
				else --| dv /= Void |--
					if title /= Void then
						set_name (title)
					else
						set_name (dv.name)
					end
					set_address (dv.address)
					if attached {ABSTRACT_REFERENCE_VALUE} dv as ref_dv then
						set_scoop_pid_value (ref_dv.scoop_processor_id)
					elseif attached {ABSTRACT_SPECIAL_VALUE} dv as spec_dv then
						set_scoop_pid_value (spec_dv.scoop_processor_id)
					else
						set_scoop_pid_value (0)
					end

					last_dump_value := Void
					inspect
						dv.kind
					when {VALUE_TYPES}.Error_message_value then
						if attached  {DUMMY_MESSAGE_DEBUG_VALUE} dv as dmdv then
							set_value (dmdv.display_message)
							set_type (debugger_names.l_no_information)
							set_pixmap (Icons [dmdv.display_kind])
						else
							check is_error_message_value: False end
						end
					when {VALUE_TYPES}.Exception_message_value then
						if attached {EXCEPTION_DEBUG_VALUE} dv as excdv then
							set_value (excdv.short_description)
							gi := value_cell
							if gi /= Void then
								gi.set_tooltip (Interface_names.l_exception_double_click_text)
								gi.pointer_double_press_actions.extend (agent (i_excdv: EXCEPTION_DEBUG_VALUE; i_x, i_y, i_but: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER) do show_exception_dialog (i_excdv) end (excdv, ?,?,?,?,?,?,?,?))
							end
							set_type (debugger_names.l_exception_data)
							set_pixmap (Icons [dv.kind])
							if excdv.has_value then
								attach_debug_value_to_grid_row (grid_extended_new_subrow (row), excdv.debug_value, Void)
							end
						else
							check is_exception_message_value: False end
						end
-- No need to handle this case apart
--					when {VALUE_TYPES}.Procedure_return_message_value then
--						set_value (interface_names.l_called)
--						set_type (once "")
--						set_pixmap (Icons [dv.kind])
					else
						last_dump_value := dv.dump_value
						set_value (last_dump_value.output_for_debugger)
						set_type (last_dump_value.generating_type_representation (generating_type_evaluation_enabled))

						set_pixmap (Icons [dv.kind])
						if dv.expandable then
							row.ensure_expandable
							set_expand_action (agent on_row_expand)
							set_collapse_action (agent on_row_collapse)
							if display then
								row.expand
							end
						end
					end
				end
				update
			end
		end

	show_exception_dialog (a_exc_dv: EXCEPTION_DEBUG_VALUE)
			-- Show `a_exc_dv' in exception dialog
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
		do
			create dlg.make
			dlg.set_exception (a_exc_dv)
			dlg.set_is_modal (True)
			dlg.show_on_active_window
		end

invariant
	object_not_void: object /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
