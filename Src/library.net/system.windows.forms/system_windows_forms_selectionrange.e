indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.SelectionRange"

frozen external class
	SYSTEM_WINDOWS_FORMS_SELECTIONRANGE

inherit
	ANY
		redefine
			to_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (range: SYSTEM_WINDOWS_FORMS_SELECTIONRANGE) is
		external
			"IL creator signature (System.Windows.Forms.SelectionRange) use System.Windows.Forms.SelectionRange"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.SelectionRange"
		end

	frozen make_1 (lower: SYSTEM_DATETIME; upper: SYSTEM_DATETIME) is
		external
			"IL creator signature (System.DateTime, System.DateTime) use System.Windows.Forms.SelectionRange"
		end

feature -- Access

	frozen get_end: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.SelectionRange"
		alias
			"get_End"
		end

	frozen get_start: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.SelectionRange"
		alias
			"get_Start"
		end

feature -- Element Change

	frozen set_start (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.SelectionRange"
		alias
			"set_Start"
		end

	frozen set_end (value: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Windows.Forms.SelectionRange"
		alias
			"set_End"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.SelectionRange"
		alias
			"ToString"
		end

end -- class SYSTEM_WINDOWS_FORMS_SELECTIONRANGE
