indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.InvalidPrinterException"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_INVALID_PRINTER_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_drawing_invalid_printer_exception

feature {NONE} -- Initialization

	frozen make_drawing_invalid_printer_exception (settings: DRAWING_PRINTER_SETTINGS) is
		external
			"IL creator signature (System.Drawing.Printing.PrinterSettings) use System.Drawing.Printing.InvalidPrinterException"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Printing.InvalidPrinterException"
		alias
			"GetObjectData"
		end

end -- class DRAWING_INVALID_PRINTER_EXCEPTION
