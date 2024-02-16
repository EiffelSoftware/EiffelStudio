note
	description: "Set of strings used during code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_STRINGS

feature -- Access

	runtime_namespace: STRING = "EiffelSoftware.Runtime"
	runtime_class_name: STRING = "EiffelSoftware.Runtime.ISE_RUNTIME"
	assertions_class_name: STRING = "EiffelSoftware.Runtime.ASSERTIONS"
	exception_manager_interface_name: STRING = "EiffelSoftware.Runtime.RT_EXCEPTION_MANAGER"
	rt_extension_interface_name: STRING = "EiffelSoftware.Runtime.RT_EXTENSION_I"
	type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_TYPE"
	type_array_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_TYPE[]"
	generic_type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_GENERIC_TYPE"
	basic_type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_BASIC_TYPE"
	class_type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_CLASS_TYPE"
	formal_type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_FORMAL_TYPE"
	none_type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_NONE_TYPE"
	tuple_type_class_name: STRING = "EiffelSoftware.Runtime.Types.RT_TUPLE_TYPE"
	generic_conformance_class_name: STRING = "EiffelSoftware.Runtime.GENERIC_CONFORMANCE"
	type_info_class_name: STRING = "EiffelSoftware.Runtime.EIFFEL_TYPE_INFO"
	integer_32_class_name: STRING = "System.Int32"
	natural_16_class_name: STRING = "System.UInt16"
	system_object_class_name: STRING = "System.Object"
	system_type_class_name: STRING = "System.Type"
	type_handle_class_name: STRING = "System.RuntimeTypeHandle"
	non_serialized_attribute_class_name: STRING = "System.NonSerializedAttribute"
	eiffel_name_attribute: STRING = "EiffelSoftware.Runtime.CA.EIFFEL_NAME_ATTRIBUTE"
	type_feature_attribute: STRING = "EiffelSoftware.Runtime.CA.TYPE_FEATURE_ATTRIBUTE"
	assertion_level_class_name_attribute: STRING = "EiffelSoftware.Runtime.CA.ASSERTION_LEVEL_ATTRIBUTE"
	interface_type_class_name_attribute: STRING = "EiffelSoftware.Runtime.CA.RT_INTERFACE_TYPE_ATTRIBUTE"
	assertion_level_enum_class_name: STRING = "EiffelSoftware.Runtime.Enums.ASSERTION_LEVEL_ENUM"
	class_type_mark_enum_class_name: STRING = "EiffelSoftware.Runtime.Enums.CLASS_TYPE_MARK_ENUM"
	class_type_mark_attribute_name: STRING = "EiffelSoftware.Runtime.CA.EIFFEL_CLASS_TYPE_MARK_ATTRIBUTE"
	eiffel_consumable_attribute: STRING = "EiffelSoftware.Runtime.CA.EIFFEL_CONSUMABLE_ATTRIBUTE"
	eiffel_version_attribute: STRING = "EiffelSoftware.Runtime.CA.EIFFEL_VERSION_ATTRIBUTE"
			-- Type used by code generation.

	override_prefix: STRING = "__"
	setter_prefix: STRING = "_set_"
			-- Prefix for automatically generated features.

	property_getter_prefix: STRING = "get_";
	property_setter_prefix: STRING = "set_";
			-- Prefix for property getter and setter methods.

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class IL_PREDEFINED_STRINGS
