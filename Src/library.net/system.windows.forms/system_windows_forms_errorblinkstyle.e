indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ErrorBlinkStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE

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

	frozen never_blink: SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorBlinkStyle"
		alias
			"2"
		end

	frozen always_blink: SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorBlinkStyle"
		alias
			"1"
		end

	frozen blink_if_different_error: SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorBlinkStyle"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_ERRORBLINKSTYLE
