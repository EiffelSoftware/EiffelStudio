indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.Emit.LocalBuilder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	LOCAL_BUILDER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_local_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.Emit.LocalBuilder"
		alias
			"get_LocalType"
		end

feature -- Basic Operations

	frozen set_local_sym_info_string_int32 (name: SYSTEM_STRING; start_offset: INTEGER; end_offset: INTEGER) is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Void use System.Reflection.Emit.LocalBuilder"
		alias
			"SetLocalSymInfo"
		end

	frozen set_local_sym_info (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Reflection.Emit.LocalBuilder"
		alias
			"SetLocalSymInfo"
		end

end -- class LOCAL_BUILDER
