indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintingPermissionLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen safe_printing: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"1"
		end

	frozen default_printing: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"2"
		end

	frozen no_printing: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"0"
		end

	frozen all_printing: SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"3"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTINGPERMISSIONLEVEL
