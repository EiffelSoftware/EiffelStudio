indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DataFormats+Format"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_FORMAT_IN_WINFORMS_DATA_FORMATS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING; id: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Windows.Forms.DataFormats+Format"
		end

feature -- Access

	frozen get_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DataFormats+Format"
		alias
			"get_Id"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DataFormats+Format"
		alias
			"get_Name"
		end

end -- class WINFORMS_FORMAT_IN_WINFORMS_DATA_FORMATS
