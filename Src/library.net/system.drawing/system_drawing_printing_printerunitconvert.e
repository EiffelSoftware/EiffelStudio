indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrinterUnitConvert"

frozen external class
	SYSTEM_DRAWING_PRINTING_PRINTERUNITCONVERT

create {NONE}

feature -- Basic Operations

	frozen convert_rectangle (value: SYSTEM_DRAWING_RECTANGLE; from_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT; to_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Rectangle use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_double (value: DOUBLE; from_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT; to_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT): DOUBLE is
		external
			"IL static signature (System.Double, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Double use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_int32 (value: INTEGER; from_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT; to_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT): INTEGER is
		external
			"IL static signature (System.Int32, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Int32 use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_point (value: SYSTEM_DRAWING_POINT; from_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT; to_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT): SYSTEM_DRAWING_POINT is
		external
			"IL static signature (System.Drawing.Point, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Point use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_margins (value: SYSTEM_DRAWING_PRINTING_MARGINS; from_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT; to_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT): SYSTEM_DRAWING_PRINTING_MARGINS is
		external
			"IL static signature (System.Drawing.Printing.Margins, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Printing.Margins use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert (value: SYSTEM_DRAWING_SIZE; from_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT; to_unit: SYSTEM_DRAWING_PRINTING_PRINTERUNIT): SYSTEM_DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.Size, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Size use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTERUNITCONVERT
