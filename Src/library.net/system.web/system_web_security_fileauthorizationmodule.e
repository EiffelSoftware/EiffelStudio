indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FileAuthorizationModule"

frozen external class
	SYSTEM_WEB_SECURITY_FILEAUTHORIZATIONMODULE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_WEB_IHTTPMODULE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Security.FileAuthorizationModule"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.FileAuthorizationModule"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Web.Security.FileAuthorizationModule"
		alias
			"Dispose"
		end

	frozen init (app: SYSTEM_WEB_HTTPAPPLICATION) is
		external
			"IL signature (System.Web.HttpApplication): System.Void use System.Web.Security.FileAuthorizationModule"
		alias
			"Init"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Security.FileAuthorizationModule"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Security.FileAuthorizationModule"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Security.FileAuthorizationModule"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_SECURITY_FILEAUTHORIZATIONMODULE
