indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrinterUnit"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_PRINTING_PRINTERUNIT

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

	frozen tenths_of_amillimeter: SYSTEM_DRAWING_PRINTING_PRINTERUNIT is
		external
			"IL enum signature :System.Drawing.Printing.PrinterUnit use System.Drawing.Printing.PrinterUnit"
		alias
			"3"
		end

	frozen thousandths_of_an_inch: SYSTEM_DRAWING_PRINTING_PRINTERUNIT is
		external
			"IL enum signature :System.Drawing.Printing.PrinterUnit use System.Drawing.Printing.PrinterUnit"
		alias
			"1"
		end

	frozen hundredths_of_amillimeter: SYSTEM_DRAWING_PRINTING_PRINTERUNIT is
		external
			"IL enum signature :System.Drawing.Printing.PrinterUnit use System.Drawing.Printing.PrinterUnit"
		alias
			"2"
		end

	frozen display: SYSTEM_DRAWING_PRINTING_PRINTERUNIT is
		external
			"IL enum signature :System.Drawing.Printing.PrinterUnit use System.Drawing.Printing.PrinterUnit"
		alias
			"0"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTERUNIT
