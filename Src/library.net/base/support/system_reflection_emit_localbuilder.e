indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.LocalBuilder"

frozen external class
	SYSTEM_REFLECTION_EMIT_LOCALBUILDER

create {NONE}

feature -- Access

	frozen get_local_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.LocalBuilder"
		alias
			"get_LocalType"
		end

feature -- Basic Operations

	frozen set_local_sym_info_string_int32 (name: STRING; start_offset: INTEGER; end_offset: INTEGER) is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Void use System.Reflection.Emit.LocalBuilder"
		alias
			"SetLocalSymInfo"
		end

	frozen set_local_sym_info (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.LocalBuilder"
		alias
			"SetLocalSymInfo"
		end

end -- class SYSTEM_REFLECTION_EMIT_LOCALBUILDER
