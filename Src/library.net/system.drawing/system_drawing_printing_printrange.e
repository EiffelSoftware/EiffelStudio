indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintRange"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_PRINTING_PRINTRANGE

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

	frozen all_pages: SYSTEM_DRAWING_PRINTING_PRINTRANGE is
		external
			"IL enum signature :System.Drawing.Printing.PrintRange use System.Drawing.Printing.PrintRange"
		alias
			"0"
		end

	frozen selection: SYSTEM_DRAWING_PRINTING_PRINTRANGE is
		external
			"IL enum signature :System.Drawing.Printing.PrintRange use System.Drawing.Printing.PrintRange"
		alias
			"1"
		end

	frozen some_pages: SYSTEM_DRAWING_PRINTING_PRINTRANGE is
		external
			"IL enum signature :System.Drawing.Printing.PrintRange use System.Drawing.Printing.PrintRange"
		alias
			"2"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTRANGE
