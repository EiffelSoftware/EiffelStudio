indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.PublisherIdentityPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PUBLISHER_IDENTITY_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK

create
	make_publisher_identity_permission_1,
	make_publisher_identity_permission

feature {NONE} -- Initialization

	frozen make_publisher_identity_permission_1 (certificate: X509_CERTIFICATE) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509Certificate) use System.Security.Permissions.PublisherIdentityPermission"
		end

	frozen make_publisher_identity_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.PublisherIdentityPermission"
		end

feature -- Access

	frozen get_certificate: X509_CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"get_Certificate"
		end

feature -- Element Change

	frozen set_certificate (value: X509_CERTIFICATE) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"set_Certificate"
		end

feature -- Basic Operations

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"Intersect"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"Union"
		end

end -- class PUBLISHER_IDENTITY_PERMISSION
