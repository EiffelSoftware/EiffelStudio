indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintingPermissionLevel"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_PRINTING_PERMISSION_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen safe_printing: DRAWING_PRINTING_PERMISSION_LEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"1"
		end

	frozen default_printing: DRAWING_PRINTING_PERMISSION_LEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"2"
		end

	frozen no_printing: DRAWING_PRINTING_PERMISSION_LEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"0"
		end

	frozen all_printing: DRAWING_PRINTING_PERMISSION_LEVEL is
		external
			"IL enum signature :System.Drawing.Printing.PrintingPermissionLevel use System.Drawing.Printing.PrintingPermissionLevel"
		alias
			"3"
		end

end -- class DRAWING_PRINTING_PERMISSION_LEVEL
