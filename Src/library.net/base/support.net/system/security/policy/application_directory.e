indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.ApplicationDirectory"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	APPLICATION_DIRECTORY

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Policy.ApplicationDirectory"
		end

feature -- Access

	frozen get_directory: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.ApplicationDirectory"
		alias
			"get_Directory"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.ApplicationDirectory"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.ApplicationDirectory"
		alias
			"ToString"
		end

	frozen copy_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Policy.ApplicationDirectory"
		alias
			"Copy"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.ApplicationDirectory"
		alias
			"Equals"
		end

end -- class APPLICATION_DIRECTORY
