indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ErrorBlinkStyle"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_ERROR_BLINK_STYLE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen never_blink: WINFORMS_ERROR_BLINK_STYLE is
		external
			"IL enum signature :System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorBlinkStyle"
		alias
			"2"
		end

	frozen always_blink: WINFORMS_ERROR_BLINK_STYLE is
		external
			"IL enum signature :System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorBlinkStyle"
		alias
			"1"
		end

	frozen blink_if_different_error: WINFORMS_ERROR_BLINK_STYLE is
		external
			"IL enum signature :System.Windows.Forms.ErrorBlinkStyle use System.Windows.Forms.ErrorBlinkStyle"
		alias
			"0"
		end

end -- class WINFORMS_ERROR_BLINK_STYLE
