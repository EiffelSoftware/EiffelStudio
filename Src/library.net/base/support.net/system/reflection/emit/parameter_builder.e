indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.ParameterBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PARAMETER_BUILDER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_is_in: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.ParameterBuilder"
		alias
			"get_IsIn"
		end

	frozen get_is_optional: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.ParameterBuilder"
		alias
			"get_IsOptional"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.ParameterBuilder"
		alias
			"get_Name"
		end

	get_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.ParameterBuilder"
		alias
			"get_Position"
		end

	get_attributes: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.ParameterBuilder"
		alias
			"get_Attributes"
		end

	frozen get_is_out: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.ParameterBuilder"
		alias
			"get_IsOut"
		end

feature -- Basic Operations

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetCustomAttribute"
		end

	get_token: PARAMETER_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.ParameterToken use System.Reflection.Emit.ParameterBuilder"
		alias
			"GetToken"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetCustomAttribute"
		end

	set_constant (default_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetConstant"
		end

	set_marshal (unmanaged_marshal: UNMANAGED_MARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetMarshal"
		end

end -- class PARAMETER_BUILDER
