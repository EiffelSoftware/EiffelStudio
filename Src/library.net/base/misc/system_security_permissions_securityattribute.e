indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.SecurityAttribute"

deferred external class
	SYSTEM_SECURITY_PERMISSIONS_SECURITYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

feature -- Access

	frozen get_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityAttribute"
		alias
			"get_Unrestricted"
		end

	frozen get_action: INTEGER is
		external
			"IL signature (): enum System.Security.Permissions.SecurityAction use System.Security.Permissions.SecurityAttribute"
		alias
			"get_Action"
		ensure
			valid_security_action: Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10
		end

feature -- Element Change

	frozen set_unrestricted (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.SecurityAttribute"
		alias
			"set_Unrestricted"
		end

	frozen set_action (value: INTEGER) is
			-- Valid values for `value' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: value = 2 or value = 3 or value = 4 or value = 5 or value = 6 or value = 7 or value = 8 or value = 9 or value = 10
		external
			"IL signature (enum System.Security.Permissions.SecurityAction): System.Void use System.Security.Permissions.SecurityAttribute"
		alias
			"set_Action"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (): System.Security.IPermission use System.Security.Permissions.SecurityAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_SECURITYATTRIBUTE
