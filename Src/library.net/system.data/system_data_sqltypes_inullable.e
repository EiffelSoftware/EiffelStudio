indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.INullable"

deferred external class
	SYSTEM_DATA_SQLTYPES_INULLABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_is_null: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Data.SqlTypes.INullable"
		alias
			"get_IsNull"
		end

end -- class SYSTEM_DATA_SQLTYPES_INULLABLE
