indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Attribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ATTRIBUTE

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Attribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	frozen is_defined_module_type (element: MODULE; attribute_type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.Module, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Attribute"
		alias
			"GetHashCode"
		end

	frozen get_custom_attribute_member_info_type (element: MEMBER_INFO; attribute_type: TYPE): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	match (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Attribute"
		alias
			"Match"
		end

	frozen get_custom_attributes_member_info_type_boolean (element: MEMBER_INFO; type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_module_type (element: MODULE; attribute_type: TYPE): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attribute_assembly_type_boolean (element: ASSEMBLY; attribute_type: TYPE; inherit_: BOOLEAN): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Assembly, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attributes_module_boolean (element: MODULE; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_assembly_type (element: ASSEMBLY; attribute_type: TYPE): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Attribute"
		alias
			"Equals"
		end

	frozen get_custom_attribute (element: ASSEMBLY; attribute_type: TYPE): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Assembly, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attributes_parameter_info_type_boolean (element: PARAMETER_INFO; attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes (element: ASSEMBLY): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen is_defined_parameter_info_type_boolean (element: PARAMETER_INFO; attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_module_type_boolean (element: MODULE; attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen get_custom_attribute_module_type (element: MODULE; attribute_type: TYPE): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Module, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen is_defined_member_info_type (element: MEMBER_INFO; attribute_type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen get_custom_attribute_module_type_boolean (element: MODULE; attribute_type: TYPE; inherit_: BOOLEAN): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attributes_module_type_boolean (element: MODULE; attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_parameter_info (element: PARAMETER_INFO): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen is_defined_assembly_type_boolean (element: ASSEMBLY; attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.Assembly, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen get_custom_attributes_member_info_type (element: MEMBER_INFO; type: TYPE): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_member_info (element: MEMBER_INFO): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_parameter_info_type (element: PARAMETER_INFO; attribute_type: TYPE): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attribute_parameter_info_type (element: PARAMETER_INFO; attribute_type: TYPE): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attributes_assembly_type_boolean (element: ASSEMBLY; attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_assembly_boolean (element: ASSEMBLY; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_module (element: MODULE): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_member_info_boolean (element: MEMBER_INFO; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_parameter_info_boolean (element: PARAMETER_INFO; inherit_: BOOLEAN): NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attribute_parameter_info_type_boolean (element: PARAMETER_INFO; attribute_type: TYPE; inherit_: BOOLEAN): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen is_defined_parameter_info_type (element: PARAMETER_INFO; attribute_type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Attribute"
		alias
			"IsDefaultAttribute"
		end

	frozen is_defined (element: ASSEMBLY; attribute_type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.Assembly, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_member_info_type_boolean (element: MEMBER_INFO; attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen get_custom_attribute_member_info_type_boolean (element: MEMBER_INFO; attribute_type: TYPE; inherit_: BOOLEAN): ATTRIBUTE is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

end -- class ATTRIBUTE
