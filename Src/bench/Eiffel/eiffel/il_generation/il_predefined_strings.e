indexing
	description: "Set of strings used during code generation"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_PREDEFINED_STRINGS

feature -- Access

	runtime_namespace: STRING is "ISE.Runtime"
	runtime_class_name: STRING is "ISE.Runtime.RUN_TIME"
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
	type_handle_class_name: STRING is "System.RuntimeTypeHandle"
			-- Type used by code generation.

	override_prefix: STRING is "__"
	setter_prefix: STRING is "_set_"
			-- Prefix for automatically generated features.

end -- class IL_PREDEFINED_STRINGS
