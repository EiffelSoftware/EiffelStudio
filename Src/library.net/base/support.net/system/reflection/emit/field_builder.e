indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.FieldBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FIELD_BUILDER

inherit
	FIELD_INFO
	ICUSTOM_ATTRIBUTE_PROVIDER

create {NONE}

feature -- Access

	get_field_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_FieldType"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.FieldBuilder"
		alias
			"get_Name"
		end

	get_reflected_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_ReflectedType"
		end

	get_declaring_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_DeclaringType"
		end

	get_field_handle: RUNTIME_FIELD_HANDLE is
		external
			"IL signature (): System.RuntimeFieldHandle use System.Reflection.Emit.FieldBuilder"
		alias
			"get_FieldHandle"
		end

	get_attributes: FIELD_ATTRIBUTES is
		external
			"IL signature (): System.Reflection.FieldAttributes use System.Reflection.Emit.FieldBuilder"
		alias
			"get_Attributes"
		end

feature -- Basic Operations

	get_value (obj: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Reflection.Emit.FieldBuilder"
		alias
			"GetValue"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetCustomAttribute"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.FieldBuilder"
		alias
			"IsDefined"
		end

	frozen set_marshal (unmanaged_marshal: UNMANAGED_MARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetMarshal"
		end

	frozen get_token: FIELD_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.FieldToken use System.Reflection.Emit.FieldBuilder"
		alias
			"GetToken"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetCustomAttribute"
		end

	set_value_object_object_binding_flags (obj: SYSTEM_OBJECT; val: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; culture: CULTURE_INFO) is
		external
			"IL signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Globalization.CultureInfo): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetValue"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.FieldBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen set_constant (default_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetConstant"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.FieldBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen set_offset (i_offset: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetOffset"
		end

end -- class FIELD_BUILDER
