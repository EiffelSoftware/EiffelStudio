indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.FieldInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	FIELD_INFO

inherit
	MEMBER_INFO
	ICUSTOM_ATTRIBUTE_PROVIDER

feature -- Access

	frozen get_is_not_serialized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsNotSerialized"
		end

	frozen get_is_family_and_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsFamilyAndAssembly"
		end

	frozen get_is_pinvoke_impl: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsPinvokeImpl"
		end

	frozen get_is_private: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsPrivate"
		end

	frozen get_is_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsAssembly"
		end

	frozen get_is_public: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsPublic"
		end

	get_field_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Reflection.FieldInfo"
		alias
			"get_FieldType"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsSpecialName"
		end

	frozen get_is_family: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsFamily"
		end

	frozen get_is_literal: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsLiteral"
		end

	get_field_handle: RUNTIME_FIELD_HANDLE is
		external
			"IL deferred signature (): System.RuntimeFieldHandle use System.Reflection.FieldInfo"
		alias
			"get_FieldHandle"
		end

	frozen get_is_static: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsStatic"
		end

	get_attributes: FIELD_ATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.FieldAttributes use System.Reflection.FieldInfo"
		alias
			"get_Attributes"
		end

	frozen get_is_init_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsInitOnly"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.FieldInfo"
		alias
			"get_MemberType"
		end

	frozen get_is_family_or_assembly: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.FieldInfo"
		alias
			"get_IsFamilyOrAssembly"
		end

feature -- Basic Operations

	set_value_object_object_binding_flags (obj: SYSTEM_OBJECT; value: SYSTEM_OBJECT; invoke_attr: BINDING_FLAGS; binder: BINDER; culture: CULTURE_INFO) is
		external
			"IL deferred signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Globalization.CultureInfo): System.Void use System.Reflection.FieldInfo"
		alias
			"SetValue"
		end

	frozen get_field_from_handle (handle: RUNTIME_FIELD_HANDLE): FIELD_INFO is
		external
			"IL static signature (System.RuntimeFieldHandle): System.Reflection.FieldInfo use System.Reflection.FieldInfo"
		alias
			"GetFieldFromHandle"
		end

	frozen set_value (obj: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Reflection.FieldInfo"
		alias
			"SetValue"
		end

	get_value (obj: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.Reflection.FieldInfo"
		alias
			"GetValue"
		end

end -- class FIELD_INFO
