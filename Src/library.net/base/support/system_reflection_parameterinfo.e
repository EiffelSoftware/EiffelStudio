indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ParameterInfo"

external class
	SYSTEM_REFLECTION_PARAMETERINFO

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	frozen get_is_in: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsIn"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.ParameterInfo"
		alias
			"get_Name"
		end

	frozen get_is_lcid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsLcid"
		end

	frozen get_is_out: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsOut"
		end

	frozen get_is_optional: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsOptional"
		end

	get_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.ParameterInfo"
		alias
			"get_Position"
		end

	get_parameter_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.ParameterInfo"
		alias
			"get_ParameterType"
		end

	frozen get_is_retval: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsRetval"
		end

	get_attributes: SYSTEM_REFLECTION_PARAMETERATTRIBUTES is
		external
			"IL signature (): System.Reflection.ParameterAttributes use System.Reflection.ParameterInfo"
		alias
			"get_Attributes"
		end

	get_default_value: ANY is
		external
			"IL signature (): System.Object use System.Reflection.ParameterInfo"
		alias
			"get_DefaultValue"
		end

	get_member: SYSTEM_REFLECTION_MEMBERINFO is
		external
			"IL signature (): System.Reflection.MemberInfo use System.Reflection.ParameterInfo"
		alias
			"get_Member"
		end

feature -- Basic Operations

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.ParameterInfo"
		alias
			"GetCustomAttributes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.ParameterInfo"
		alias
			"GetHashCode"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.ParameterInfo"
		alias
			"GetCustomAttributes"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"IsDefined"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.ParameterInfo"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.ParameterInfo"
		alias
			"Finalize"
		end

end -- class SYSTEM_REFLECTION_PARAMETERINFO
