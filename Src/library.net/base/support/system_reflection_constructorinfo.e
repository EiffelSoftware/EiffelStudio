indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ConstructorInfo"

deferred external class
	SYSTEM_REFLECTION_CONSTRUCTORINFO

inherit
	SYSTEM_REFLECTION_METHODBASE
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	frozen type_constructor_name: STRING is
		external
			"IL static_field signature :System.String use System.Reflection.ConstructorInfo"
		alias
			"TypeConstructorName"
		end

	frozen constructor_name: STRING is
		external
			"IL static_field signature :System.String use System.Reflection.ConstructorInfo"
		alias
			"ConstructorName"
		end

	get_member_type: SYSTEM_REFLECTION_MEMBERTYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.ConstructorInfo"
		alias
			"get_MemberType"
		end

feature -- Basic Operations

	frozen invoke_array_object (parameters: ARRAY [ANY]): ANY is
		external
			"IL signature (System.Object[]): System.Object use System.Reflection.ConstructorInfo"
		alias
			"Invoke"
		end

	invoke_binding_flags (invoke_attr: SYSTEM_REFLECTION_BINDINGFLAGS; binder: SYSTEM_REFLECTION_BINDER; parameters: ARRAY [ANY]; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): ANY is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.ConstructorInfo"
		alias
			"Invoke"
		end

end -- class SYSTEM_REFLECTION_CONSTRUCTORINFO
