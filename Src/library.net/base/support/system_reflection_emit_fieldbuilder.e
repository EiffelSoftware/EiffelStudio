indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.FieldBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_FIELDBUILDER

inherit
	SYSTEM_REFLECTION_FIELDINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	get_attributes: INTEGER is
		external
			"IL signature (): enum System.Reflection.FieldAttributes use System.Reflection.Emit.FieldBuilder"
		alias
			"get_Attributes"
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

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.FieldBuilder"
		alias
			"get_Name"
		end

	get_field_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_FieldType"
		end

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.FieldBuilder"
		alias
			"get_ReflectedType"
		end

feature -- Basic Operations

	frozen set_offset (iOffset: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetOffset"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.FieldBuilder"
		alias
			"GetCustomAttributes"
		end

	frozen set_custom_attribute_with_blob (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binaryAttribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetCustomAttribute"
		end

	frozen set_marshal (unmanagedMarshal: SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL) is
		external
			"IL signature (System.Reflection.Emit.UnmanagedMarshal): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetMarshal"
		end

	frozen set_constant (defaultValue: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetConstant"
		end

	get_custom_attributes_for_type (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.FieldBuilder"
		alias
			"GetCustomAttributes"
		end

	is_defined (attributeType: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.FieldBuilder"
		alias
			"IsDefined"
		end

	frozen get_token: SYSTEM_REFLECTION_EMIT_FIELDTOKEN is
		external
			"IL signature (): System.Reflection.Emit.FieldToken use System.Reflection.Emit.FieldBuilder"
		alias
			"GetToken"
		end

	get_value (obj: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Reflection.Emit.FieldBuilder"
		alias
			"GetValue"
		end

	set_value_with_options (obj: ANY; val: ANY; invokeAttr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Object, System.Object, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Globalization.CultureInfo): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetValue"
		end

	frozen set_custom_attribute (customBuilder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.FieldBuilder"
		alias
			"SetCustomAttribute"
		end

end -- class SYSTEM_REFLECTION_EMIT_FIELDBUILDER
