indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.PublisherIdentityPermissionAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_PUBLISHERIDENTITYPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_publisheridentitypermissionattribute

feature {NONE} -- Initialization

	frozen make_publisheridentitypermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.PublisherIdentityPermissionAttribute"
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
