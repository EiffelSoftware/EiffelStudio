indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.PropertyBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PROPERTY_BUILDER

inherit
	PROPERTY_INFO
		redefine
			set_value,
			get_value
		end
	ICUSTOM_ATTRIBUTE_PROVIDER

create {NONE}

feature -- Access

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_Name"
		end

	get_reflected_type: TYPE is
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

	get_declaring_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_DeclaringType"
		end

	frozen get_property_token: PROPERTY_TOKEN is
		external
			"IL signature (): System.Reflection.Emit.PropertyToken use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_PropertyToken"
		end

	get_property_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.PropertyBuilder"
		alias
			"get_PropertyType"
		end

	get_attributes: PROPERTY_ATTRIBUTES is
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

	get_get_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetGetMethod"
		end

	set_value (obj: SYSTEM_OBJECT; value: SYSTEM_OBJECT; index: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object, System.Object, System.Object[]): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetValue"
		end

	set_value_object_object_binding_flags (obj: SYSTEM_OBJECT; value: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; index: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO) is
		external
			"IL signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetValue"
		end

	get_accessors_boolean (non_public: BOOLEAN): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (System.Boolean): System.Reflection.MethodInfo[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetAccessors"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Type, System.Boolean): System.Boolean use System.Reflection.Emit.PropertyBuilder"
		alias
			"IsDefined"
		end

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Type, System.Boolean): System.Object[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetCustomAttributes"
		end

	get_index_parameters: NATIVE_ARRAY [PARAMETER_INFO] is
		external
			"IL signature (): System.Reflection.ParameterInfo[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetIndexParameters"
		end

	frozen set_custom_attribute (custom_builder: CUSTOM_ATTRIBUTE_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.CustomAttributeBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetCustomAttribute"
		end

	get_set_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetSetMethod"
		end

	frozen set_constant (default_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetConstant"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (System.Boolean): System.Object[] use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetCustomAttributes"
		end

	get_value (obj: SYSTEM_OBJECT; index: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Object[]): System.Object use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetValue"
		end

	frozen set_set_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetSetMethod"
		end

	frozen add_other_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"AddOtherMethod"
		end

	frozen set_get_method (md_builder: METHOD_BUILDER) is
		external
			"IL signature (System.Reflection.Emit.MethodBuilder): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetGetMethod"
		end

	get_value_object_binding_flags (obj: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; index: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.Emit.PropertyBuilder"
		alias
			"GetValue"
		end

	frozen set_custom_attribute_constructor_info (con: CONSTRUCTOR_INFO; binary_attribute: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Reflection.ConstructorInfo, System.Byte[]): System.Void use System.Reflection.Emit.PropertyBuilder"
		alias
			"SetCustomAttribute"
		end

end -- class PROPERTY_BUILDER
