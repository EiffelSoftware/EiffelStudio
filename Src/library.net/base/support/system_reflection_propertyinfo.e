indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.PropertyInfo"

deferred external class
	SYSTEM_REFLECTION_PROPERTYINFO

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_CanWrite"
		end

	get_property_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.PropertyInfo"
		alias
			"get_PropertyType"
		end

	get_member_type: SYSTEM_REFLECTION_MEMBERTYPES is
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

	get_attributes: SYSTEM_REFLECTION_PROPERTYATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.PropertyAttributes use System.Reflection.PropertyInfo"
		alias
			"get_Attributes"
		end

feature -- Basic Operations

	frozen get_set_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetSetMethod"
		end

	get_set_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetSetMethod"
		end

	set_value (obj: ANY; value: ANY; index: ARRAY [ANY]) is
		external
			"IL signature (System.Object, System.Object, System.Object[]): System.Void use System.Reflection.PropertyInfo"
		alias
			"SetValue"
		end

	get_value_object_binding_flags (obj: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; index: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL deferred signature (System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.PropertyInfo"
		alias
			"GetValue"
		end

	get_get_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetGetMethod"
		end

	set_value_object_object_binding_flags (obj: ANY; value: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; index: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL deferred signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Void use System.Reflection.PropertyInfo"
		alias
			"SetValue"
		end

	frozen get_accessors: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetAccessors"
		end

	get_index_parameters: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO] is
		external
			"IL deferred signature (): System.Reflection.ParameterInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetIndexParameters"
		end

	get_accessors_boolean (non_public: BOOLEAN): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetAccessors"
		end

	frozen get_get_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetGetMethod"
		end

	get_value (obj: ANY; index: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object, System.Object[]): System.Object use System.Reflection.PropertyInfo"
		alias
			"GetValue"
		end

end -- class SYSTEM_REFLECTION_PROPERTYINFO
