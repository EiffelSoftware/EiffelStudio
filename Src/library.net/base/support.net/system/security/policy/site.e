indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.Site"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SITE

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
			"IL creator signature (System.String) use System.Security.Policy.Site"
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Site"
		alias
			"get_Name"
		end

feature -- Basic Operations

	frozen create_from_url (url: SYSTEM_STRING): SITE is
		external
			"IL static signature (System.String): System.Security.Policy.Site use System.Security.Policy.Site"
		alias
			"CreateFromUrl"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Site"
		alias
			"GetHashCode"
		end

	frozen copy_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Policy.Site"
		alias
			"Copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Site"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: EVIDENCE): IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.Site"
		alias
			"CreateIdentityPermission"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Site"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Site"
		alias
			"Finalize"
		end

end -- class SITE
