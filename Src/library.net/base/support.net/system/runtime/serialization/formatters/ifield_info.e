indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.Formatters.IFieldInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IFIELD_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_field_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"get_FieldNames"
		end

	get_field_types: NATIVE_ARRAY [TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"get_FieldTypes"
		end

feature -- Element Change

	set_field_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL deferred signature (System.String[]): System.Void use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"set_FieldNames"
		end

	set_field_types (value: NATIVE_ARRAY [TYPE]) is
		external
			"IL deferred signature (System.Type[]): System.Void use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"set_FieldTypes"
		end

end -- class IFIELD_INFO
