indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.PropertyInfo"

deferred external class
	SYSTEM_REFLECTION_PROPERTYINFO

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	get_attributes: INTEGER is
		external
			"IL deferred signature (): enum System.Reflection.PropertyAttributes use System.Reflection.PropertyInfo"
		alias
			"get_Attributes"
		ensure
			valid_property_attributes: Result = 0 or Result = 512 or Result = 62464 or Result = 1024 or Result = 4096 or Result = 8192 or Result = 16384 or Result = 32768
		end

	get_property_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.PropertyInfo"
		alias
			"get_PropertyType"
		end

	get_can_write: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_CanWrite"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_IsSpecialName"
		end

	get_member_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.MemberTypes use System.Reflection.PropertyInfo"
		alias
			"get_MemberType"
		end

	get_can_read: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Reflection.PropertyInfo"
		alias
			"get_CanRead"
		end

feature -- Basic Operations

	get_set_all_method (nonPublic: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetSetMethod"
		end

	get_get_all_method (nonPublic: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetGetMethod"
		end

	get_all_accessors (nonPublic: BOOLEAN): ARRAY [SYSTEM_REFLECTION_METHODINFO] is
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

	set_value (obj: ANY; value: ANY; index: ARRAY [ANY]) is
		external
			"IL signature (System.Object, System.Object, System.Object[]): System.Void use System.Reflection.PropertyInfo"
		alias
			"SetValue"
		end

	frozen get_accessors: ARRAY [SYSTEM_REFLECTION_METHODINFO] is
		external
			"IL signature (): System.Reflection.MethodInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetAccessors"
		end

	get_value_with_binding_index_and_culture (obj: ANY; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; index: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
			-- Valid values for `invoke_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & invoke_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (System.Object, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.PropertyInfo"
		alias
			"GetValue"
		end

	get_value (obj: ANY; index: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object, System.Object[]): System.Object use System.Reflection.PropertyInfo"
		alias
			"GetValue"
		end

	set_value_with_binding_index_and_culture (obj: ANY; value: ANY; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; index: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
			-- Valid values for `invoke_attr' are a combination of the following values:
			-- Default = 0
			-- IgnoreCase = 1
			-- DeclaredOnly = 2
			-- Instance = 4
			-- Static = 8
			-- Public = 16
			-- NonPublic = 32
			-- FlattenHierarchy = 64
			-- InvokeMethod = 256
			-- CreateInstance = 512
			-- GetField = 1024
			-- SetField = 2048
			-- GetProperty = 4096
			-- SetProperty = 8192
			-- PutDispProperty = 16384
			-- PutRefDispProperty = 32768
			-- ExactBinding = 65536
			-- SuppressChangeType = 131072
			-- OptionalParamBinding = 262144
			-- IgnoreReturn = 16777216
		require
			valid_binding_flags: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216) & invoke_attr = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 65536 + 131072 + 262144 + 16777216
		external
			"IL deferred signature (System.Object, System.Object, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Void use System.Reflection.PropertyInfo"
		alias
			"SetValue"
		end

	get_index_parameters: ARRAY [SYSTEM_REFLECTION_PARAMETERINFO] is
		external
			"IL deferred signature (): System.Reflection.ParameterInfo[] use System.Reflection.PropertyInfo"
		alias
			"GetIndexParameters"
		end

	frozen get_set_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.PropertyInfo"
		alias
			"GetSetMethod"
		end

end -- class SYSTEM_REFLECTION_PROPERTYINFO
