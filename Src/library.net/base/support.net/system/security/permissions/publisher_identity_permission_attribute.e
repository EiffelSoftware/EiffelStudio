indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.PublisherIdentityPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PUBLISHER_IDENTITY_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_publisher_identity_permission_attribute

feature {NONE} -- Initialization

	frozen make_publisher_identity_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		end

feature -- Access

	frozen get_signed_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"get_SignedFile"
		end

	frozen get_x509_certificate: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"get_X509Certificate"
		end

	frozen get_cert_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"get_CertFile"
		end

feature -- Element Change

	frozen set_x509_certificate (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"set_X509Certificate"
		end

	frozen set_cert_file (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"set_CertFile"
		end

	frozen set_signed_file (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"set_SignedFile"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class PUBLISHER_IDENTITY_PERMISSION_ATTRIBUTE
