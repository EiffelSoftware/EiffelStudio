indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.PropertyBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_PROPERTYBUILDER

inherit
	SYSTEM_REFLECTION_PROPERTYINFO
		redefine
			set_value,
			get_value
		end
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

create {NONE}

feature -- Access

	get_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_Name"
		end

	get_reflected_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_ReflectedType"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_CanRead"
		end

	get_declaring_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_DeclaringType"
		end

	frozen get_property_token: SYSTEM_REFLECTION_EMIT_PROPERTYTOKEN is
		external
			"IL signature (): System.Reflection.Emit.PropertyToken use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_PropertyToken"
		end

	get_property_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_PropertyType"
		end

	get_attributes: SYSTEM_REFLECTION_PROPERTYATTRIBUTES is
		external
			"IL signature (): System.Reflection.PropertyAttributes use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_Attributes"
		end

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_CanWrite"
		end

feature -- Basic Operations

	get_get_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetGetMethod"
		end

	set_value (obj: ANY; value: ANY; index: ARRAY [ANY]) is
		external
			"IL signature (System.Object, System.Object, System.Object[]): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetValue"
		end

	set_value_object_object_binding_flags (obj: ANY; value: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; index: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetValue"
		end

	get_accessors_boolean (non_public: BOOLEAN): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (System.Boolean): System.Reflection.MethodInfo[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetAccessors"
		end

	is_defined (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.PropertyBuilder"
		alias
			"IsDefined"
		end

	get_custom_attributes_type (attribute_type: SYSTEM_TYPE; inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetCustomAttributes"
		end

	get_index_parameters: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO] is
		external
			"IL signature (): System.Reflection.ParameterInfo[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetIndexParameters"
		end

	frozen set_custom_attribute (custom_builder: SYSTEM_REFLECTION_EMIT_CUSTOMATTRIBUTEBUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetCustomAttribute"
		end

	get_set_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetSetMethod"
		end

	frozen set_constant (default_value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetConstant"
		end

	get_custom_attributes (inherit_: BOOLEAN): ARRAY [ANY] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetCustomAttributes"
		end

	get_value (obj: ANY; index: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object, System.Object[]): System.Object use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetValue"
		end

	frozen set_set_method (md_builder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetSetMethod"
		end

	frozen add_other_method (md_builder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"AddOtherMethod"
		end

	frozen set_get_method (md_builder: SYSTEM_REFLECTION_EMIT_METHODBUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetGetMethod"
		end

	get_value_object_binding_flags (obj: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; index: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL signature (System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetValue"
		end

	frozen set_custom_attribute_constructor_info (con: SYSTEM_REFLECTION_CONSTRUCTORINFO; binary_attribute: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetCustomAttribute"
		end

end -- class SYSTEM_REFLECTION_EMIT_PROPERTYBUILDER
