indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.INullable"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_INULLABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_is_null: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Data.SqlTypes.INullable"
		alias
			"get_IsNull"
		end

end -- class DATA_INULLABLE
