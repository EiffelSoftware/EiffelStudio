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

	ES_OBJECTS_GRID_LINE
		rename
			data as object,
			set_data as set_object
		redefine
			object,
			reset_special_attributes_values,
			recycle,
			get_object_stone_properties
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

	recycle is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
			object := Void
		end

feature -- Properties

	object: ABSTRACT_DEBUG_VALUE

	object_name: STRING is
		do
			Result := object.name
		end

	object_address: STRING

	object_dynamic_class: CLASS_C is
		do
			Result := object.dynamic_class
		end

	object_spec_capacity: INTEGER

feature -- Object stone

	get_object_stone_properties is

		local
			cl: CLASS_C
			fost: FEATURED_OBJECT_STONE
			fst: FEATURE_STONE
			ostn: STRING
			addr: STRING
			feat: E_FEATURE
		do
			Precursor
			if internal_object_stone = Void and then related_line /= Void then
				ostn := object_name
				if ostn /= Void then
					cl := related_line.object_dynamic_class
					if cl /= Void then
						feat := cl.feature_with_name (ostn)
						if feat /= Void then
							addr := related_line.object_address
							if addr /= Void then
								create fost.make (addr, feat)
								internal_object_stone_accept_cursor := fost.stone_cursor
								internal_object_stone_deny_cursor := fost.X_stone_cursor
								internal_object_stone := fost
							else
								create fst.make (feat)
								internal_object_stone_accept_cursor := fst.stone_cursor
								internal_object_stone_deny_cursor := fst.X_stone_cursor
								internal_object_stone := fst
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

	related_line: ES_OBJECTS_GRID_LINE

feature -- Query

	has_attributes_values: BOOLEAN is
		do
			Result := object.expandable
		end

	reset_special_attributes_values is
		local
			spec_items: ABSTRACT_SPECIAL_VALUE
		do
			spec_items ?= object
			if spec_items /= Void then
				spec_items.reset_items
				spec_items.set_sp_bounds (object_spec_lower, object_spec_upper)
			end
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		do
			Result := object.sorted_children
		end

	sorted_once_functions: LIST [E_FEATURE] is
		local
			l_class: CLASS_C
		do
			l_class := object_dynamic_class
			if l_class = Void then
				--| Q: Why do we have Void dynamic_class ?
				--| ANSWER : because of external class in dotnet system
				--| Should be fixed now by using SYSTEM_OBJECT for unknown type
			else
				Result := l_class.once_functions
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
		do
			if row /= Void and not compute_grid_display_done then
				compute_grid_display_done := True
				dv := object
				if dv = Void then
					last_dump_value := Void
					set_name ("No object")
					set_value (Void)
					set_type (Void)
					set_address (Void)
					set_pixmap (Icons @ (Void_value))
				else --| dv /= Void |--
					set_name (dv.name)
					set_address (dv.address)

					last_dump_value := Void
					if dv.kind = Error_message_value then
						dmdv ?= dv
						set_value (dmdv.display_message)
						set_type (once "Invalid data")
						set_pixmap (Icons @ (dmdv.display_kind))
					elseif dv.kind = Exception_message_value then
						excdv ?= dv
						set_value (excdv.display_tag)
						set_type (once "Exception data")
						set_pixmap (Icons @ (dv.kind))
						if excdv.debug_value /= Void then
							attach_debug_value_to_grid_row (grid_extended_new_subrow (row), excdv.debug_value, "Exception object")
						end
					else
						last_dump_value := dv.dump_value
						set_value (last_dump_value.output_for_debugger)
						set_type (last_dump_value.generating_type_representation)

						set_pixmap (Icons @ (dv.kind))
						if dv.expandable then
							row.ensure_expandable
							expand_actions.extend (agent on_row_expand)
							collapse_actions.extend (agent on_row_collapse)
							if display then
								row.expand
							end
						end
					end
				end
				update
			end
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
