indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.FieldBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_FIELDBUILDER

inherit
	SYSTEM_REFLECTION_FIELDINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	get_field_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_FieldType"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.FieldBuilder"
		alias
			"get_Name"
		end

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_ReflectedType"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_DeclaringType"
		end

	get_field_handle: SYSTEM_RUNTIMEFIELDHANDLE is
		external
			"IL signature (): System.RuntimeFieldHandle use System.Reflection.Emit.FieldBuilder"
		alias
			"get_FieldHandle"
		end

	get_attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES is
		external
			"IL signature (): System.Reflection.FieldAttributes use System.Reflection.Emit.FieldBuilder"
		alias
			"get_Attributes"
		end

feature -- Basic Operations

	get_value (obj: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Reflection.Emit.FieldBuilder"
		alias
			"GetValue"
		end

	frozen set_custom_attribute (custom_builder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetCustomAttribute"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.FieldBuilder"
		alias
			"IsDefined"
		end

	frozen set_marshal (unmanaged_marshal: SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetMarshal"
		end

	frozen get_token: SYSTEM_REFLECTION_EMIT_FIELDTOKEN is
		external
			"IL signature (): System.Reflection.Emit.FieldToken use System.Reflection.Emit.FieldBuilder"
		alias
			"GetToken"
		end

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binary_attribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetCustomAttribute"
		end

	set_value_object_object_binding_flags (obj: ANY; val: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Globalization.CultureInfo): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetValue"
		end

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.FieldBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen set_constant (default_value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetConstant"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
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

end -- class SYSTEM_REFLECTION_EMIT_FIELDBUILDER
