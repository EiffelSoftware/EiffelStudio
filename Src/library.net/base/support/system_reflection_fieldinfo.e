indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.FieldInfo"

deferred external class
	SYSTEM_REFLECTION_FIELDINFO

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	frozen get_is_literal: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsLiteral"
		end

	get_member_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.MemberTypes use System.Reflection.FieldInfo"
		alias
			"get_MemberType"
		end

	get_attributes: INTEGER is
		external
			"IL deferred signature (): enum System.Reflection.FieldAttributes use System.Reflection.FieldInfo"
		alias
			"get_Attributes"
		ensure
			valid_field_attributes: Result = 7 or Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 512 or Result = 8192 or Result = 38144 or Result = 1024 or Result = 4096 or Result = 32768 or Result = 256
		end

	frozen get_is_family_and_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsFamilyAndAssembly"
		end

	frozen get_is_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsAssembly"
		end

	get_field_handle: SYSTEM_RUNTIMEFIELDHANDLE is
		external
			"IL deferred signature (): System.RuntimeFieldHandle use System.Reflection.FieldInfo"
		alias
			"get_FieldHandle"
		end

	get_field_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.FieldInfo"
		alias
			"get_FieldType"
		end

	frozen get_is_family: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsFamily"
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsPublic"
		end

	frozen get_is_init_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsInitOnly"
		end

	frozen get_is_private: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsPrivate"
		end

	frozen get_is_pinvoke_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsPinvokeImpl"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsSpecialName"
		end

	frozen get_is_family_or_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsFamilyOrAssembly"
		end

	frozen get_is_not_serialized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsNotSerialized"
		end

	frozen get_is_static: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsStatic"
		end

feature -- Basic Operations

	get_value (obj: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.Reflection.FieldInfo"
		alias
			"GetValue"
		end

	frozen get_field_from_handle (handle: SYSTEM_RUNTIMEFIELDHANDLE): SYSTEM_REFLECTION_FIELDINFO is
		external
			"IL static signature (System.RuntimeFieldHandle): System.Reflection.FieldInfo use System.Reflection.FieldInfo"
		alias
			"GetFieldFromHandle"
		end

	frozen set_value (obj: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Reflection.FieldInfo"
		alias
			"SetValue"
		end

	set_value_with_options (obj: ANY; value: ANY; invoke_attr: INTEGER; binder: SYSTEM_REFLECTION_BINDER; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
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
			"IL deferred signature (System.Object, System.Object, enum System.Reflection.BindingFlags, System.Reflection.Binder, System.Globalization.CultureInfo): System.Void use System.Reflection.FieldInfo"
		alias
			"SetValue"
		end

end -- class SYSTEM_REFLECTION_FIELDINFO
