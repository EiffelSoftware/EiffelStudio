indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.Url"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	URL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IIDENTITY_PERMISSION_FACTORY

create
	make

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Policy.Url"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Url"
		alias
			"get_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Url"
		alias
			"GetHashCode"
		end

	frozen copy_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Policy.Url"
		alias
			"Copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Url"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: EVIDENCE): IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.Url"
		alias
			"CreateIdentityPermission"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Url"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Url"
		alias
			"Finalize"
		end

end -- class URL
