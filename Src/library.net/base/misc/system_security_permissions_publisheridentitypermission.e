indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.PublisherIdentityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_PUBLISHERIDENTITYPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_publisheridentitypermission,
	make_publisheridentitypermission_1

feature {NONE} -- Initialization

	frozen make_publisheridentitypermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.PublisherIdentityPermission"
		end

	frozen make_publisheridentitypermission_1 (certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509Certificate) use System.Security.Permissions.PublisherIdentityPermission"
		end

feature -- Access

	frozen get_certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"get_Certificate"
		end

feature -- Element Change

	frozen set_certificate (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"set_Certificate"
		end

feature -- Basic Operations

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PublisherIdentityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_PUBLISHERIDENTITYPERMISSION
