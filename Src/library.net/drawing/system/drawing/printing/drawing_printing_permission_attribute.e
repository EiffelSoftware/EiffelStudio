indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintingPermissionAttribute"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PRINTING_PERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_drawing_printing_permission_attribute

feature {NONE} -- Initialization

	frozen make_drawing_printing_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Drawing.Printing.PrintingPermissionAttribute"
		end

feature -- Access

	frozen get_level: DRAWING_PRINTING_PERMISSION_LEVEL is
		external
			"IL signature (): System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionAttribute"
		alias
			"get_Level"
		end

feature -- Element Change

	frozen set_level (value: DRAWING_PRINTING_PERMISSION_LEVEL) is
		external
			"IL signature (System.Drawing.Printing.PrintingPermissionLevel): System.Void use System.Drawing.Printing.PrintingPermissionAttribute"
		alias
			"set_Level"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Drawing.Printing.PrintingPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class DRAWING_PRINTING_PERMISSION_ATTRIBUTE
