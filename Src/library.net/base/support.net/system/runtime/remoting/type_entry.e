indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.TypeEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TYPE_ENTRY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.TypeEntry"
		alias
			"get_TypeName"
		end

	frozen get_assembly_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.TypeEntry"
		alias
			"get_AssemblyName"
		end

feature -- Element Change

	frozen set_assembly_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.TypeEntry"
		alias
			"set_AssemblyName"
		end

	frozen set_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.TypeEntry"
		alias
			"set_TypeName"
		end

end -- class TYPE_ENTRY
