indexing
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

	make_with_value (dv: ABSTRACT_DEBUG_VALUE; g: like parent_grid) is
		require
			dv /= Void
		local
			conv_abs_ref: ABSTRACT_REFERENCE_VALUE
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
		do
			make_with_grid (g)
			conv_abs_ref ?= dv
			if conv_abs_ref /= Void then
				object_address := conv_abs_ref.address
			else
				conv_abs_spec ?= dv
				if conv_abs_spec /= Void then
					object_address := conv_abs_spec.address
					object_is_special_value := True
					object_spec_capacity := conv_abs_spec.capacity
				else
					object_address := Void -- "Unknown address"
				end
			end
			set_object (dv)
		end

feature -- Recycling

	reset is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
			object := Void
		end

feature -- Properties

	object: ABSTRACT_DEBUG_VALUE

	object_name: STRING_32 is
		do
			Result := object.name
		end

	object_address: DBG_ADDRESS
			-- <Precursor>

	object_dynamic_class: CLASS_C is
		do
			Result := object.dynamic_class
			if Result = Void then
				Result := object.static_class
			end
		end

	object_spec_capacity: INTEGER

feature {NONE} -- Object stone

	get_items_stone_properties is
		local
			cl: CLASS_C
			fst: FEATURE_STONE
			fost: FEATURE_ON_OBJECT_STONE
			objst: OBJECT_STONE
			ostn: STRING
			feat: E_FEATURE
			t: like internal_item_stone_data_i_th
		do
			Precursor
			if related_line /= Void then
				ostn := object_name
				if ostn /= Void then
					cl := related_line.object_dynamic_class
					if cl /= Void then
						feat := cl.feature_with_name (ostn)
						if feat /= Void then
								--| Note: `related_line.object_address' can be Void
							create fost.make (related_line.object_address, feat)
							t := internal_item_stone_data_i_th (0)
							if t /= Void then
								objst ?= t.pebble
								if objst /= Void then
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
						end
					end
				end
			end
		end

feature -- Related line if precised

	set_related_line (v: like related_line) is
		do
			related_line := v
		end

	related_line: ES_OBJECTS_GRID_OBJECT_LINE

feature -- Query

	has_attributes_values: BOOLEAN is
		do
			Result := object.expandable
		end

	reset_special_attributes_values is
		do
			if {spec_items: ABSTRACT_SPECIAL_VALUE} object then
				spec_items.reset_items
				spec_items.set_sp_bounds (object_spec_lower, object_spec_upper)
			end
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			Result := object.sorted_children
		end

	sorted_once_routines: LIST [E_FEATURE] is
		do
			if {l_class: like object_dynamic_class} object_dynamic_class then
				Result := l_class.once_routines
			else
				--| Q: Why do we have Void dynamic_class ?
				--| ANSWER : because of external class in dotnet system
				--| Should be fixed now by using SYSTEM_OBJECT for unknown type
			end
		end

	sorted_constant_features: LIST [E_CONSTANT] is
		do
			if {l_class: like object_dynamic_class} object_dynamic_class then
				Result := l_class.constant_features
			else
				--| Q: Why do we have Void dynamic_class ?
			end
		end

	associated_dump_value: DUMP_VALUE is
		do
			Result := internal_associated_dump_value
			if Result = Void then
				Result := object.dump_value
				internal_associated_dump_value := Result
			end
		end

	internal_associated_dump_value: like associated_dump_value

feature -- Graphical changes

	compute_grid_display is
		local
			dv: ABSTRACT_DEBUG_VALUE
			dmdv: DUMMY_MESSAGE_DEBUG_VALUE
			excdv: EXCEPTION_DEBUG_VALUE
			gi: EV_GRID_ITEM
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
					set_pixmap (Icons @ ({VALUE_TYPES}.Void_value))
				else --| dv /= Void |--
					if title /= Void then
						set_name (title)
					else
						set_name (dv.name)
					end
					set_address (dv.address)

					last_dump_value := Void
					inspect
						dv.kind
					when {VALUE_TYPES}.Error_message_value then
						dmdv ?= dv
						set_value (dmdv.display_message)
						set_type (debugger_names.l_no_information)
						set_pixmap (Icons @ (dmdv.display_kind))
					when {VALUE_TYPES}.Exception_message_value then
						excdv ?= dv
						set_value (excdv.short_description)
						gi := value_cell
						if gi /= Void then
							gi.set_tooltip (Interface_names.l_exception_double_click_text)
							gi.pointer_double_press_actions.force_extend (agent show_exception_dialog (excdv))
						end
						set_type (debugger_names.l_exception_data)
						set_pixmap (Icons @ (dv.kind))
						if excdv.has_value then
							attach_debug_value_to_grid_row (grid_extended_new_subrow (row), excdv.debug_value, Void)
						end
					when {VALUE_TYPES}.Procedure_return_message_value then
						set_value (interface_names.l_called)
						set_type (once "")
						set_pixmap (Icons @ (dv.kind))
					else
						last_dump_value := dv.dump_value
						set_value (last_dump_value.output_for_debugger)
						set_type (last_dump_value.generating_type_representation (generating_type_evaluation_enabled))

						set_pixmap (Icons @ (dv.kind))
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

invariant
	object_not_void: object /= Void

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
