indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrinterUnitConvert"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PRINTER_UNIT_CONVERT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen convert_rectangle (value: DRAWING_RECTANGLE; from_unit: DRAWING_PRINTER_UNIT; to_unit: DRAWING_PRINTER_UNIT): DRAWING_RECTANGLE is
		external
			"IL static signature (System.Drawing.Rectangle, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Rectangle use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_double (value: DOUBLE; from_unit: DRAWING_PRINTER_UNIT; to_unit: DRAWING_PRINTER_UNIT): DOUBLE is
		external
			"IL static signature (System.Double, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Double use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_int32 (value: INTEGER; from_unit: DRAWING_PRINTER_UNIT; to_unit: DRAWING_PRINTER_UNIT): INTEGER is
		external
			"IL static signature (System.Int32, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Int32 use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_point (value: DRAWING_POINT; from_unit: DRAWING_PRINTER_UNIT; to_unit: DRAWING_PRINTER_UNIT): DRAWING_POINT is
		external
			"IL static signature (System.Drawing.Point, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Point use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert_margins (value: DRAWING_MARGINS; from_unit: DRAWING_PRINTER_UNIT; to_unit: DRAWING_PRINTER_UNIT): DRAWING_MARGINS is
		external
			"IL static signature (System.Drawing.Printing.Margins, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Printing.Margins use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

	frozen convert (value: DRAWING_SIZE; from_unit: DRAWING_PRINTER_UNIT; to_unit: DRAWING_PRINTER_UNIT): DRAWING_SIZE is
		external
			"IL static signature (System.Drawing.Size, System.Drawing.Printing.PrinterUnit, System.Drawing.Printing.PrinterUnit): System.Drawing.Size use System.Drawing.Printing.PrinterUnitConvert"
		alias
			"Convert"
		end

end -- class DRAWING_PRINTER_UNIT_CONVERT
