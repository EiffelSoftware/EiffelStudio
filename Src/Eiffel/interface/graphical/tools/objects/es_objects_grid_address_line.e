note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_ADDRESS_LINE

inherit

	ES_OBJECTS_GRID_OBJECT_LINE
		rename
			data as object_address,
			set_data as set_object_address
		redefine
			object_address,
			reset
		end

create
	make_with_address,
	make_with_call_stack_element,
	make_with_dump_value

feature {NONE}

	make_with_address (add: DBG_ADDRESS; dtype: CLASS_C; g: like parent_grid)
		require
			add /= Void
		do
			make_with_grid (g)
			object_dynamic_class := dtype
			object_is_special_value := object_dynamic_class.is_special or object_dynamic_class.is_native_array
			set_object_address (add)
		end

	make_with_call_stack_element (elem: EIFFEL_CALL_STACK_ELEMENT; g: like parent_grid)
			-- Initialize `Current' and associate it with object
			-- represented by `elem'.
		require
			elem_not_void: elem /= Void
		do
			make_with_address (elem.object_address, elem.dynamic_class, g)
		end

	make_with_dump_value (dumpvalue: DUMP_VALUE; g: like parent_grid)
			-- Initialize `Current' and associate it with object
			-- represented by `elem'.
		require
			dumpvalue_not_void: dumpvalue /= Void
		do
			last_dump_value := dumpvalue
			make_with_address (dumpvalue.address, dumpvalue.dynamic_class, g)
		end

feature -- Recycling

	reset
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			Precursor
			internal_associated_dump_value := Void
		end

feature -- Properties

	object_name: STRING_32
		do
			Result := title
		end

	object_address: DBG_ADDRESS

	object_dynamic_class: CLASS_C

	object_spec_count_and_capacity: TUPLE [spec_count, spec_capacity: INTEGER]
		do
			Result := debugger_manager.object_manager.special_object_count_and_capacity_at_address (object_address)
		end

feature -- Query

	has_attributes_values: BOOLEAN
		do
			if attached object_address as oadd and then is_valid_and_known_object_address (oadd) then
				Result := debugger_manager.object_manager.object_at_address_has_attributes (oadd)
			end
		end

	sorted_attributes_values: DS_LIST [ABSTRACT_DEBUG_VALUE]
		do
			if attached object_address as oadd and then is_valid_and_known_object_address (oadd) then
				Result := debugger_manager.object_manager.sorted_attributes_at_address (oadd, object_spec_lower, object_spec_upper)
			end
		end

	sorted_once_routines: LIST [E_FEATURE]
			-- <Precursor>	
		do
			if attached object_dynamic_class as cl then
				Result := cl.once_routines
			end
		end

	sorted_constant_features: LIST [E_CONSTANT]
			-- <Precursor>
		do
			if attached object_dynamic_class as cl then
				Result := cl.constant_features
			end
		end

	object_value: STRING_32
			-- Full ouput representation for related object
		do
			if last_dump_value = Void then
				get_last_dump_value
			end
			Result := last_dump_value.output_for_debugger
		end

	object_type_representation: STRING
			-- Full ouput representation for related object
		do
			if last_dump_value = Void then
				get_last_dump_value
			end
			Result := last_dump_value.generating_type_representation (generating_type_evaluation_enabled)
		end

	get_last_dump_value
		do
			last_dump_value := associated_dump_value
		ensure
			last_dump_value /= Void
		end

	associated_dump_value: DUMP_VALUE
		do
			Result := internal_associated_dump_value
			if Result = Void then
				Result := debugger_manager.application.dump_value_at_address_with_class (object_address, object_dynamic_class)
				internal_associated_dump_value := Result
			end
		end

	internal_associated_dump_value: like associated_dump_value

feature -- Graphical changes

	compute_grid_display
		do
			if row /= Void and not compute_grid_display_done then
				compute_grid_display_done := True
				if title = Void then
					set_name ("default")
				else
					set_name (title)
				end
				set_value (object_value)
				set_type (object_type_representation)
				set_address (object_address)
				if object_dynamic_class /= Void and then object_dynamic_class.is_expanded then
					set_pixmap (icons [{VALUE_TYPES}.expanded_value])
				else
					set_pixmap (icons [{VALUE_TYPES}.reference_value])
				end
				row.ensure_expandable
				set_expand_action (agent on_row_expand)
				set_collapse_action (agent on_row_collapse)
				if display then
					row.expand
				end

				update
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
