indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintingPermission"

frozen external class
	SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_ISTACKWALK

create
	make_printingpermission,
	make_printingpermission_1

feature {NONE} -- Initialization

	frozen make_printingpermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Drawing.Printing.PrintingPermission"
		end

	frozen make_printingpermission_1 (printing_level: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL) is
		external
			"IL creator signature (System.Drawing.Printing.PrintingPermissionLevel) use System.Drawing.Printing.PrintingPermission"
		end

feature -- Access

	frozen get_level: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL is
		external
			"IL signature (): System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermission"
		alias
			"get_Level"
		end

feature -- Element Change

	frozen set_level (value: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL) is
		external
			"IL signature (System.Drawing.Printing.PrintingPermissionLevel): System.Void use System.Drawing.Printing.PrintingPermission"
		alias
			"set_Level"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Drawing.Printing.PrintingPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Drawing.Printing.PrintingPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Drawing.Printing.PrintingPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Printing.PrintingPermission"
		alias
			"IsUnrestricted"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Drawing.Printing.PrintingPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Drawing.Printing.PrintingPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Drawing.Printing.PrintingPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSION
