indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SelectionRange"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_SELECTION_RANGE

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (range: WINFORMS_SELECTION_RANGE) is
		external
			"IL creator signature (System.Windows.Forms.SelectionRange) use System.Windows.Forms.SelectionRange"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.SelectionRange"
		end

	frozen make_1 (lower: SYSTEM_DATE_TIME; upper: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.DateTime, System.DateTime) use System.Windows.Forms.SelectionRange"
		end

feature -- Access

	frozen get_end: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.SelectionRange"
		alias
			"get_End"
		end

	frozen get_start: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.SelectionRange"
		alias
			"get_Start"
		end

feature -- Element Change

	frozen set_start (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.SelectionRange"
		alias
			"set_Start"
		end

	frozen set_end (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.SelectionRange"
		alias
			"set_End"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.SelectionRange"
		alias
			"ToString"
		end

end -- class WINFORMS_SELECTION_RANGE
