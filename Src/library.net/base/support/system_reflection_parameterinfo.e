indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	get_member: SYSTEM_REFLECTION_MEMBERINFO is
		external
			"IL signature (): System.Reflection.MemberInfo use System.Reflection.ParameterInfo"
		alias
			"get_Member"
		end

	get_default_value: ANY is
		external
			"IL signature (): System.Object use System.Reflection.ParameterInfo"
		alias
			"get_DefaultValue"
		end

	get_attributes: INTEGER is
		external
			"IL signature (): enum System.Reflection.ParameterAttributes use System.Reflection.ParameterInfo"
		alias
			"get_Attributes"
		ensure
			valid_parameter_attributes: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 61440 or Result = 4096 or Result = 8192 or Result = 16384 or Result = 32768
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

	get_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.ParameterInfo"
		alias
			"get_Position"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.ParameterInfo"
		alias
			"get_Name"
		end

	frozen get_is_optional: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsOptional"
		end

	frozen get_is_in: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"get_IsIn"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"Equals"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.ParameterInfo"
		alias
			"GetCustomAttributes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.ParameterInfo"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Reflection.ParameterInfo"
		alias
			"ToString"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.ParameterInfo"
		alias
			"IsDefined"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.ParameterInfo"
		alias
			"GetCustomAttributes"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Reflection.ParameterInfo"
		alias
			"Finalize"
		end

end -- class SYSTEM_REFLECTION_PARAMETERINFO
