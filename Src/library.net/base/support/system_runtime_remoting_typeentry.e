indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.TypeEntry"

external class
	SYSTEM_RUNTIME_REMOTING_TYPEENTRY

create {NONE}

feature -- Access

	frozen get_assembly_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.TypeEntry"
		alias
			"get_AssemblyName"
		end

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.TypeEntry"
		alias
			"get_TypeName"
		end

feature -- Element Change

	frozen set_assembly_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.TypeEntry"
		alias
			"set_AssemblyName"
		end

	frozen set_type_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.TypeEntry"
		alias
			"set_TypeName"
		end

end -- class SYSTEM_RUNTIME_REMOTING_TYPEENTRY
