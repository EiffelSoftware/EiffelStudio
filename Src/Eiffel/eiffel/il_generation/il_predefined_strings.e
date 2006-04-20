indexing
	description: "Set of strings used during code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_STRINGS

feature -- Access

	runtime_namespace: STRING is "EiffelSoftware.Runtime"
	runtime_class_name: STRING is "EiffelSoftware.Runtime.ISE_RUNTIME"
	assertions_class_name: STRING is "EiffelSoftware.Runtime.ASSERTIONS"
	type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_TYPE"
	type_array_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_TYPE[]"
	generic_type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_GENERIC_TYPE"
	basic_type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_BASIC_TYPE"
	class_type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_CLASS_TYPE"
	formal_type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_FORMAL_TYPE"
	none_type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_NONE_TYPE"
	tuple_type_class_name: STRING is "EiffelSoftware.Runtime.Types.RT_TUPLE_TYPE"
	generic_conformance_class_name: STRING is "EiffelSoftware.Runtime.GENERIC_CONFORMANCE"
	type_info_class_name: STRING is "EiffelSoftware.Runtime.EIFFEL_TYPE_INFO"
	integer_32_class_name: STRING is "System.Int32"
	system_object_class_name: STRING is "System.Object"
	system_type_class_name: STRING is "System.Type"
	type_handle_class_name: STRING is "System.RuntimeTypeHandle"
	eiffel_name_attribute: STRING is "EiffelSoftware.Runtime.CA.EIFFEL_NAME_ATTRIBUTE"
	type_feature_attribute: STRING is "EiffelSoftware.Runtime.CA.TYPE_FEATURE_ATTRIBUTE"
	assertion_level_class_name_attribute: STRING is "EiffelSoftware.Runtime.CA.ASSERTION_LEVEL_ATTRIBUTE"
	interface_type_class_name_attribute: STRING is "EiffelSoftware.Runtime.CA.RT_INTERFACE_TYPE_ATTRIBUTE"
	assertion_level_enum_class_name: STRING is "EiffelSoftware.Runtime.Enums.ASSERTION_LEVEL_ENUM"
	eiffel_consumable_attribute: STRING is "EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE"
	eiffel_exception_class_name: STRING is "EiffelSoftware.Runtime.EIFFEL_EXCEPTION"
			-- Type used by code generation.

	override_prefix: STRING is "__"
	setter_prefix: STRING is "_set_"
			-- Prefix for automatically generated features.

	property_getter_prefix: STRING is "__get__";
	property_setter_prefix: STRING is "__set__";
			-- Prefix for property getter and setter methods.

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

end -- class IL_PREDEFINED_STRINGS
