indexing
	description: "Set of strings used during code generation"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_STRINGS

feature -- Access

	runtime_namespace: STRING is "ISE.Runtime"
	runtime_class_name: STRING is "ISE.Runtime.RUN_TIME"
	assertions_class_name: STRING is "ISE.Runtime.ASSERTIONS"
	type_class_name: STRING is "ISE.Runtime.TYPE"
	type_array_class_name: STRING is "ISE.Runtime.TYPE[]"
	generic_type_class_name: STRING is "ISE.Runtime.GENERIC_TYPE"
	basic_type_class_name: STRING is "ISE.Runtime.BASIC_TYPE"
	class_type_class_name: STRING is "ISE.Runtime.CLASS_TYPE"
	formal_type_class_name: STRING is "ISE.Runtime.FORMAL_TYPE"
	none_type_class_name: STRING is "ISE.Runtime.NONE_TYPE"
	generic_conformance_class_name: STRING is "ISE.Runtime.GENERIC_CONFORMANCE"
	type_info_class_name: STRING is "ISE.Runtime.EIFFEL_TYPE_INFO"
	integer_32_class_name: STRING is "System.Int32"
	system_object_class_name: STRING is "System.Object"
	system_type_class_name: STRING is "System.Type"
	type_handle_class_name: STRING is "System.RuntimeTypeHandle"
	eiffel_class_name_attribute: STRING is "ISE.Runtime.CA.EIFFEL_CLASS_NAME_ATTRIBUTE"
	assertion_level_class_name_attribute: STRING is "ISE.Runtime.CA.ASSERTION_LEVEL_ATTRIBUTE"
	interface_type_class_name_attribute: STRING is "ISE.Runtime.CA.INTERFACE_TYPE_ATTRIBUTE"
	assertion_level_enum_class_name: STRING is "ISE.Runtime.Enums.ASSERTION_LEVEL_ENUM"
	eiffel_derivation_class_name: STRING is "ISE.Runtime.EIFFEL_DERIVATION"
	eiffel_exception_class_name: STRING is "ISE.Runtime.EIFFEL_EXCEPTION"
			-- Type used by code generation.

	override_prefix: STRING is "__"
	setter_prefix: STRING is "_set_"
			-- Prefix for automatically generated features.

end -- class IL_PREDEFINED_STRINGS
