indexing
	description: "Dotnet debug value associated with String value"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_STRING_VALUE

inherit
	ABSTRACT_REFERENCE_VALUE
		redefine
			output_value, kind, expandable,
			reset_children
		end

	EIFNET_ABSTRACT_DEBUG_VALUE
		undefine
			address
		redefine
			output_value, kind, expandable,
			reset_children
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

create {RECV_VALUE, ATTR_REQUEST,CALL_STACK_ELEMENT, DEBUG_VALUE_EXPORTER}
	make

feature {NONE} -- Initialization

	make (a_referenced_value: like icd_referenced_value; a_prepared_value: like icd_value) is
			-- 	Set `value' to `v'.
		require
			a_prepared_value_not_void: a_prepared_value /= Void
		do
			set_default_name

			init_dotnet_data (a_referenced_value, a_prepared_value)

			get_icd_string_value
			if icd_string_value /= Void then
				length := icd_string_value.get_length
				release_icd_string_value
			end

			is_external_type := True
			get_truncated_string_value (debugger_manager.displayed_string_size)

			is_null := (length = 0)
			if is_null then
				create address.make_void
			else
				create address.make_from_integer_64 (icd_value_info.object_address)
			end
			register_dotnet_data
		ensure
			value_set: icd_value = a_prepared_value
		end

feature -- get

	get_truncated_string_value (a_size: INTEGER) is
			-- Get the `a_size' first character of the full string value
			-- store this truncated string into `string_value'
		do
			string_value := icd_value_info.value_to_truncated_string (a_size)
		end

	get_icd_string_value is
			-- Get `icd_string_value'
		do
			icd_string_value := icd_value_info.interface_debug_string_value
		end

	release_icd_string_value is
			-- Release `icd_string_value'
		do
			icd_string_value.clean_on_dispose
			icd_string_value := Void
		end

feature -- Access

	icd_string_value: ICOR_DEBUG_STRING_VALUE
			-- String value

	length: INTEGER
			-- Capacity/Size of the String value

	dynamic_class: CLASS_C is
			-- Find corresponding CLASS_C to type represented by `value'.
		once
			Result := debugger_manager.compiler_data.system_string_class_c
		ensure then
			non_void_result: Result /= Void
		end

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_string_for_dotnet_value (Current)
		end

feature -- Change

	reset_children is
		do
			attributes := Void
		end

feature {NONE} -- Output

	output_value: STRING_32 is
			-- A STRING representation of the value of `Current'.
		do
			Result := string_value
		end

	type_and_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			create Result.make (40)
			Result.append (dynamic_class.name_in_upper)
			Result.append (Equal_sign_str)
			Result.append (output_value)
		end

feature -- Output	

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		local
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
		do
			l_icdov := icd_value_info.new_interface_debug_object_value
			if l_icdov /= Void then
				Result := True
				l_icdov.clean_on_dispose
			end
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := attributes
			if Result = Void then
				Result := children_from_external_type
				attributes := Result
			end
		end

	attributes: DS_LIST [ABSTRACT_DEBUG_VALUE]

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if is_null then
				Result := Void_value
			else
				if is_static then
					Result := Static_external_reference_value
				else
					Result := External_reference_value
				end
			end
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

end -- class EIFNET_DEBUG_STRING_VALUE

