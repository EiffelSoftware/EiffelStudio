indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintingPermission"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PRINTING_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_drawing_printing_permission,
	make_drawing_printing_permission_1

feature {NONE} -- Initialization

	frozen make_drawing_printing_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Drawing.Printing.PrintingPermission"
		end

	frozen make_drawing_printing_permission_1 (printing_level: DRAWING_PRINTING_PERMISSION_LEVEL) is
		external
			"IL creator signature (System.Drawing.Printing.PrintingPermissionLevel) use System.Drawing.Printing.PrintingPermission"
		end

feature -- Access

	frozen get_level: DRAWING_PRINTING_PERMISSION_LEVEL is
		external
			"IL signature (): System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermission"
		alias
			"get_Level"
		end

feature -- Element Change

	frozen set_level (value: DRAWING_PRINTING_PERMISSION_LEVEL) is
		external
			"IL signature (System.Drawing.Printing.PrintingPermissionLevel): System.Void use System.Drawing.Printing.PrintingPermission"
		alias
			"set_Level"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Drawing.Printing.PrintingPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Drawing.Printing.PrintingPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
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

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Drawing.Printing.PrintingPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Drawing.Printing.PrintingPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Drawing.Printing.PrintingPermission"
		alias
			"Union"
		end

end -- class DRAWING_PRINTING_PERMISSION
