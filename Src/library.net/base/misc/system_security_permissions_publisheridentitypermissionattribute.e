indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.PublisherIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_PUBLISHERIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_publisheridentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_publisheridentitypermissionattribute (action: INTEGER) is
			-- Valid values for `action' are:
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
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_signed_file: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"get_SignedFile"
		end

	frozen get_x509_certificate: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"get_X509Certificate"
		end

	frozen get_cert_file: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"get_CertFile"
		end

feature -- Element Change

	frozen set_x509_certificate (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"set_X509Certificate"
		end

	frozen set_cert_file (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"set_CertFile"
		end

	frozen set_signed_file (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"set_SignedFile"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_PUBLISHERIDENTITYPERMISSIONATTRIBUTE
