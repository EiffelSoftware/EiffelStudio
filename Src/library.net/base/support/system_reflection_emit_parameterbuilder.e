indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.ParameterBuilder"

external class
	SYSTEM_REFLECTION_EMIT_PARAMETERBUILDER

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

	get_name: STRING is
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

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binary_attribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetCustomAttribute"
		end

	get_token: SYSTEM_REFLECTION_EMIT_PARAMETERTOKEN is
		external
			"IL signature (): System.Reflection.Emit.ParameterToken use System.Reflection.Emit.ParameterBuilder"
		alias
			"GetToken"
		end

	frozen set_custom_attribute (custom_builder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetCustomAttribute"
		end

	set_constant (default_value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetConstant"
		end

	set_marshal (unmanaged_marshal: SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.ParameterBuilder"
		alias
			"SetMarshal"
		end

end -- class SYSTEM_REFLECTION_EMIT_PARAMETERBUILDER
