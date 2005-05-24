indexing
	description: "Set of strings used during code generation"
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
	interface_type_class_name_attribute: STRING is "EiffelSoftware.Runtime.CA.INTERFACE_TYPE_ATTRIBUTE"
	assertion_level_enum_class_name: STRING is "EiffelSoftware.Runtime.Enums.ASSERTION_LEVEL_ENUM"
	eiffel_exception_class_name: STRING is "EiffelSoftware.Runtime.EIFFEL_EXCEPTION"
			-- Type used by code generation.

	override_prefix: STRING is "__"
	setter_prefix: STRING is "_set_"
			-- Prefix for automatically generated features.

end -- class IL_PREDEFINED_STRINGS
