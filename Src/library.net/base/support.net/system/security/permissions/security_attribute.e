indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SecurityAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SECURITY_ATTRIBUTE

inherit
	ATTRIBUTE

feature -- Access

	frozen get_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityAttribute"
		alias
			"get_Unrestricted"
		end

	frozen get_action: SECURITY_ACTION is
		external
			"IL signature (): System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAttribute"
		alias
			"get_Action"
		end

feature -- Element Change

	frozen set_unrestricted (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityAttribute"
		alias
			"set_Unrestricted"
		end

	frozen set_action (value: SECURITY_ACTION) is
		external
			"IL signature (System.Security.Permissions.SecurityAction): System.Void use System.Security.Permissions.SecurityAttribute"
		alias
			"set_Action"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL deferred signature (): System.Security.IPermission use System.Security.Permissions.SecurityAttribute"
		alias
			"CreatePermission"
		end

end -- class SECURITY_ATTRIBUTE
