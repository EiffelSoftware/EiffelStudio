indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ICustomAttributeProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICUSTOM_ATTRIBUTE_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_custom_attributes_type (attribute_type: TYPE; inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Object[] use System.Reflection.ICustomAttributeProvider"
		alias
			"GetCustomAttributes"
		end

	get_custom_attributes (inherit_: BOOLEAN): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (System.Boolean): System.Object[] use System.Reflection.ICustomAttributeProvider"
		alias
			"GetCustomAttributes"
		end

	is_defined (attribute_type: TYPE; inherit_: BOOLEAN): BOOLEAN is
		external
			"IL deferred signature (System.Type, System.Boolean): System.Boolean use System.Reflection.ICustomAttributeProvider"
		alias
			"IsDefined"
		end

end -- class ICUSTOM_ATTRIBUTE_PROVIDER
