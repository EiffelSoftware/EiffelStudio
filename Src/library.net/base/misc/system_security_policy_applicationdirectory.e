indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.ApplicationDirectory"

frozen external class
	SYSTEM_SECURITY_POLICY_APPLICATIONDIRECTORY

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (name: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Policy.ApplicationDirectory"
		end

feature -- Access

	frozen get_directory: STRING is
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

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.ApplicationDirectory"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.ApplicationDirectory"
		alias
			"ToString"
		end

	frozen copy: ANY is
		external
			"IL signature (): System.Object use System.Security.Policy.ApplicationDirectory"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_POLICY_APPLICATIONDIRECTORY
