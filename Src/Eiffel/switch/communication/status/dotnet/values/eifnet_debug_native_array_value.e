indexing
	description: "Dotnet debug value associated with NativeArray value"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_NATIVE_ARRAY_VALUE

inherit

	ABSTRACT_SPECIAL_VALUE
		redefine
			kind,
			extra_output_details
		end

	EIFNET_ABSTRACT_DEBUG_VALUE
		rename
			reset_children as reset_items
		undefine
			address,
			sorted_children,
			reset_items
		redefine
			extra_output_details
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make --, make_attribute

feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value) is
			-- 	Set `value' to `a_prepared_value'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
		do
			set_default_name

			init_dotnet_data (a_referenced_value, a_prepared_value)

			is_null := icd_value_info.is_null
			if not is_null then
				address := icd_value_info.address_as_hex_string
			end

			get_array_value
			if array_value /= Void then
				capacity := array_value.get_count
				release_array_value
			end
			register_dotnet_data

			set_sp_bounds (debugger_manager.min_slice, debugger_manager.max_slice)
		ensure
			value_set: icd_value = a_prepared_value
		end

--	make_attribute (attr_name: like name; a_class: like e_class; v: like value) is
--			-- Set `attr_name' to `name' and `value' to `v'.
--		require
--			not_attr_name_void: attr_name /= Void
--			v_not_void: v /= Void
--		do
--			name := attr_name
--			if a_class /= Void then
--				e_class := a_class
--				is_attribute := True
--			end
--			value := v
--		ensure
--			value_set: value = v
--		end

feature -- get

	get_array_value is
			-- get `array_value'
		do
			array_value := icd_value_info.interface_debug_array_value
		end

	release_array_value is
			-- Release `array_value'
		do
			array_value.clean_on_dispose
			array_value := Void
		end

feature -- Access

	array_value: ICOR_DEBUG_ARRAY_VALUE

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
			Result := debugger_manager.compiler_data.native_array_class_c
		ensure then
			non_void_result: Result /= Void
		end

	string_value: STRING is
			-- If `Current' represents a string then return its value.
			-- Else return Void.
			-- but in dotnet, STRING are not represented as SPECIAL[CHARACTER]
		do
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_native_array_object_for_dotnet_value (Current)
		end

feature -- Output

	extra_output_details: STRING_32 is
		do
			get_array_value
			Result := " count=" + array_value.get_count.out + " rank=" + array_value.get_rank.out
			release_array_value
		end

feature -- Output	

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if is_null then
				Result := Void_value
			else
				if is_static then
					Result := Static_reference_value
				else
					Result := Special_value
				end
			end
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			if items_computed then
				Result := items
			else
				reset_items
				get_items (sp_lower, sp_upper)
				Result := items
			end
		end

	get_items (a_slice_min, a_slice_max: INTEGER) is
			-- Get Items for attributes
		require else
			slice_valid: a_slice_min <= a_slice_max
		local
			l_elt: ICOR_DEBUG_VALUE
			l_att_debug_value: ABSTRACT_DEBUG_VALUE
			i: INTEGER
			nb_items: INTEGER
		do
			if capacity > 0 then
				set_sp_bounds (a_slice_min, (capacity - 1).min (a_slice_max))
				if sp_lower <= sp_upper then
					nb_items := sp_upper - sp_lower + 1
					if nb_items > items.capacity then
						items.resize (nb_items)
					end
					get_array_value
					from
						i := sp_lower
					until
						i > sp_upper
					loop
						l_elt := array_value.get_element_at_position (i)
						if l_elt /= Void then
							l_att_debug_value := debug_value_from_icdv (l_elt, Void)
							l_att_debug_value.set_name (i.out)
							items.put_last (l_att_debug_value)
						end
						i := i + 1
					end
					release_array_value
				end
			end
			items_computed := True
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

end -- class EIFNET_DEBUG_NATIVE_ARRAY_VALUE
