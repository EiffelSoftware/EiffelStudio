indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ConstructorInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	CONSTRUCTOR_INFO

inherit
	METHOD_BASE
	ICUSTOM_ATTRIBUTE_PROVIDER

feature -- Access

	frozen type_constructor_name: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Reflection.ConstructorInfo"
		alias
			"TypeConstructorName"
		end

	frozen constructor_name: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Reflection.ConstructorInfo"
		alias
			"ConstructorName"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.ConstructorInfo"
		alias
			"get_MemberType"
		end

feature -- Basic Operations

	frozen invoke_array_object (parameters: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL signature (System.Object[]): System.Object use System.Reflection.ConstructorInfo"
		alias
			"Invoke"
		end

	invoke_binding_flags (invoke_attr: BINDING_FLAGS; binder: BINDER; parameters: NATIVE_ARRAY [SYSTEM_OBJECT]; culture: CULTURE_INFO): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Reflection.BindingFlags, System.Reflection.Binder, System.Object[], System.Globalization.CultureInfo): System.Object use System.Reflection.ConstructorInfo"
		alias
			"Invoke"
		end

end -- class CONSTRUCTOR_INFO
