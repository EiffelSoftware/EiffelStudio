indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MessageBoxButtons"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS

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

	frozen ok: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxButtons use System.Windows.Forms.MessageBoxButtons"
		alias
			"0"
		end

	frozen okcancel: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxButtons use System.Windows.Forms.MessageBoxButtons"
		alias
			"1"
		end

	frozen yes_no: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxButtons use System.Windows.Forms.MessageBoxButtons"
		alias
			"4"
		end

	frozen abort_retry_ignore: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxButtons use System.Windows.Forms.MessageBoxButtons"
		alias
			"2"
		end

	frozen retry_cancel: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxButtons use System.Windows.Forms.MessageBoxButtons"
		alias
			"5"
		end

	frozen yes_no_cancel: SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxButtons use System.Windows.Forms.MessageBoxButtons"
		alias
			"3"
		end

end -- class SYSTEM_WINDOWS_FORMS_MESSAGEBOXBUTTONS
