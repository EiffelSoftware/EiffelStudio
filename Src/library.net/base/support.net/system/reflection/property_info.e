indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.PropertyInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	PROPERTY_INFO

inherit
	MEMBER_INFO
	ICUSTOM_ATTRIBUTE_PROVIDER

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_CanWrite"
		end

	get_property_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.PropertyInfo"
		alias
			"get_PropertyType"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.PropertyInfo"
		alias
			"get_MemberType"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_IsSpecialName"
		end

	get_can_read: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_CanRead"
		end

	get_attributes: PROPERTY_ATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.PropertyAttributes use System.Reflection.PropertyInfo"
		alias
			"get_Attributes"
		end

feature -- Basic Operations

	frozen get_set_method: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetSetMethod"
		end

	get_set_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetSetMethod"
		end

	set_value (obj: SYSTEM_OBJECT; value: SYSTEM_OBJECT; index: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object, System.Object, System.Object[]): System.Void use System.Reflection.PropertyInfo"
		alias
			"SetValue"
		end

	get_value_object_binding_flags (obj: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; index: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.PropertyInfo"
		alias
			"GetValue"
		end

	get_get_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetGetMethod"
		end

	set_value_object_object_binding_flags (obj: SYSTEM_OBJECT; value: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; index: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO) is
		external
			"IL deferred signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Void use System.Reflection.PropertyInfo"
		alias
			"SetValue"
		end

	frozen get_accessors: NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetAccessors"
		end

	get_index_parameters: NATIVE_ARRAY [PARAMETER_INFO] is
		external
			"IL deferred signature (): System.Reflection.ParameterInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetIndexParameters"
		end

	get_accessors_boolean (non_public: BOOLEAN): NATIVE_ARRAY [METHOD_INFO] is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetAccessors"
		end

	frozen get_get_method: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetGetMethod"
		end

	get_value (obj: SYSTEM_OBJECT; index: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Object[]): System.Object use System.Reflection.PropertyInfo"
		alias
			"GetValue"
		end

end -- class PROPERTY_INFO
