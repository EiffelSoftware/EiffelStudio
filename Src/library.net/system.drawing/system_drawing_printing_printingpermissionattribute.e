indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintingPermissionAttribute"

frozen external class
	SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_printingpermissionattribute

feature {NONE} -- Initialization

	frozen make_printingpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Drawing.Printing.PrintingPermissionAttribute"
		end

feature -- Access

	frozen get_level: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL is
		external
			"IL signature (): System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionAttribute"
		alias
			"get_Level"
		end

feature -- Element Change

	frozen set_level (value: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL) is
		external
			"IL signature (System.Drawing.Printing.PrintingPermissionLevel): System.Void use System.Drawing.Printing.PrintingPermissionAttribute"
		alias
			"set_Level"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Drawing.Printing.PrintingPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONATTRIBUTE
