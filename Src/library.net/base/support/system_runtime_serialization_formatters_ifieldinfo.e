indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.Formatters.IFieldInfo"

deferred external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_IFIELDINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_field_names: ARRAY [STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"get_FieldNames"
		end

	get_field_types: ARRAY [SYSTEM_TYPE] is
		external
			"IL deferred signature (): System.Type[] use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"get_FieldTypes"
		end

feature -- Element Change

	set_field_names (value: ARRAY [STRING]) is
		external
			"IL deferred signature (System.String[]): System.Void use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"set_FieldNames"
		end

	set_field_types (value: ARRAY [SYSTEM_TYPE]) is
		external
			"IL deferred signature (System.Type[]): System.Void use System.Runtime.Serialization.Formatters.IFieldInfo"
		alias
			"set_FieldTypes"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_IFIELDINFO
