indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Attribute"

deferred external class
	SYSTEM_ATTRIBUTE

inherit
	ANY
		redefine
			get_hash_code,
			is_equal
		end

feature -- Access

	get_type_id: ANY is
		external
			"IL signature (): System.Object use System.Attribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	frozen get_custom_attribute (element: SYSTEM_REFLECTION_ASSEMBLY; attribute_type: SYSTEM_TYPE): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Assembly, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_on_member (element: SYSTEM_REFLECTION_MEMBERINFO; attribute_type: SYSTEM_TYPE): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_on_module (element: SYSTEM_REFLECTION_MODULE; attribute_type: SYSTEM_TYPE): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Module, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_on_parameter (element: SYSTEM_REFLECTION_PARAMETERINFO; attribute_type: SYSTEM_TYPE): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_on_parameter_inherited (element: SYSTEM_REFLECTION_PARAMETERINFO; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_on_member_inherited (element: SYSTEM_REFLECTION_MEMBERINFO; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_inherited (element: SYSTEM_REFLECTION_ASSEMBLY; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Assembly, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen get_custom_attribute_on_module_inherited (element: SYSTEM_REFLECTION_MODULE; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): SYSTEM_ATTRIBUTE is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Boolean): System.Attribute use System.Attribute"
		alias
			"GetCustomAttribute"
		end

	frozen is_defined (element: SYSTEM_REFLECTION_ASSEMBLY; attribute_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.Assembly, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_module (element: SYSTEM_REFLECTION_MODULE; attribute_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.Module, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_parameter (element: SYSTEM_REFLECTION_PARAMETERINFO; attribute_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_member (element: SYSTEM_REFLECTION_MEMBERINFO; attribute_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_parameter_inherited (element: SYSTEM_REFLECTION_PARAMETERINFO; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_assembly_inherited (element: SYSTEM_REFLECTION_ASSEMBLY; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.Assembly, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_module_inherited (element: SYSTEM_REFLECTION_MODULE; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen is_defined_for_member_inherited (element: SYSTEM_REFLECTION_MEMBERINFO; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type, System.Boolean): System.Boolean use System.Attribute"
		alias
			"IsDefined"
		end

	frozen get_custom_attributes (element: SYSTEM_REFLECTION_ASSEMBLY): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_parameter (element: SYSTEM_REFLECTION_PARAMETERINFO): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_module (element: SYSTEM_REFLECTION_MODULE): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_member (element: SYSTEM_REFLECTION_MEMBERINFO): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_assembly (element: SYSTEM_REFLECTION_ASSEMBLY; attribute_type: SYSTEM_TYPE): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_member (element: SYSTEM_REFLECTION_MEMBERINFO; type: SYSTEM_TYPE): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_module (element: SYSTEM_REFLECTION_MODULE; attribute_type: SYSTEM_TYPE): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_parameter (element: SYSTEM_REFLECTION_PARAMETERINFO; attribute_type: SYSTEM_TYPE): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_on_parameter_inherited (element: SYSTEM_REFLECTION_PARAMETERINFO; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_on_assembly_inherited (element: SYSTEM_REFLECTION_ASSEMBLY; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_on_member_inherited (element: SYSTEM_REFLECTION_MEMBERINFO; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_on_module_inherited (element: SYSTEM_REFLECTION_MODULE; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_parameter_inherited (element: SYSTEM_REFLECTION_PARAMETERINFO; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.ParameterInfo, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_module_inherited (element: SYSTEM_REFLECTION_MODULE; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Module, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_assembly_inherited (element: SYSTEM_REFLECTION_ASSEMBLY; attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.Assembly, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	frozen get_custom_attributes_for_type_on_member_inherited (element: SYSTEM_REFLECTION_MEMBERINFO; type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL static signature (System.Reflection.MemberInfo, System.Type, System.Boolean): System.Attribute[] use System.Attribute"
		alias
			"GetCustomAttributes"
		end

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Attribute"
		alias
			"IsDefaultAttribute"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Attribute"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Attribute"
		alias
			"GetHashCode"
		end

	match (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Attribute"
		alias
			"Match"
		end

end -- class SYSTEM_ATTRIBUTE
