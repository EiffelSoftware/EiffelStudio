indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.FieldInfo"

deferred external class
	SYSTEM_REFLECTION_FIELDINFO

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

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

	get_field_type: SYSTEM_TYPE is
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

	get_field_handle: SYSTEM_RUNTIMEFIELDHANDLE is
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

	get_attributes: SYSTEM_REFLECTION_FIELDATTRIBUTES is
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

	get_member_type: SYSTEM_REFLECTION_MEMBERTYPES is
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

	set_value_object_object_binding_flags (obj: ANY; value: ANY; invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL deferred signature (System.Object, System.Object, System.Reflection.BindingFlags, System.Reflection.Binder, System.Globalization.CultureInfo): System.Void use System.Reflection.FieldInfo"
		alias
			"SetValue"
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

	get_value (obj: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.Reflection.FieldInfo"
		alias
			"GetValue"
		end

end -- class SYSTEM_REFLECTION_FIELDINFO
