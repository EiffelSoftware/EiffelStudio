indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.MethodInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	METHOD_INFO

inherit
	METHOD_BASE
	ICUSTOM_ATTRIBUTE_PROVIDER

feature -- Access

	get_return_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.MethodInfo"
		alias
			"get_ReturnType"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.MethodInfo"
		alias
			"get_MemberType"
		end

	get_return_type_custom_attributes: ICUSTOM_ATTRIBUTE_PROVIDER is
		external
			"IL deferred signature (): System.Reflection.ICustomAttributeProvider use System.Reflection.MethodInfo"
		alias
			"get_ReturnTypeCustomAttributes"
		end

feature -- Basic Operations

	get_base_definition: METHOD_INFO is
		external
			"IL deferred signature (): System.Reflection.MethodInfo use System.Reflection.MethodInfo"
		alias
			"GetBaseDefinition"
		end

end -- class METHOD_INFO
