indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.MethodInfo"

deferred external class
	SYSTEM_REFLECTION_METHODINFO

inherit
	SYSTEM_REFLECTION_METHODBASE
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	get_return_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.MethodInfo"
		alias
			"get_ReturnType"
		end

	get_return_type_custom_attributes: SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER is
		external
			"IL deferred signature (): System.Reflection.ICustomAttributeProvider use System.Reflection.MethodInfo"
		alias
			"get_ReturnTypeCustomAttributes"
		end

	get_member_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.MemberTypes use System.Reflection.MethodInfo"
		alias
			"get_MemberType"
		end

feature -- Basic Operations

	get_base_definition: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (): System.Reflection.MethodInfo use System.Reflection.MethodInfo"
		alias
			"GetBaseDefinition"
		end

end -- class SYSTEM_REFLECTION_METHODINFO
