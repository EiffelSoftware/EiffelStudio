indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.FormWindowState"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_FORM_WINDOW_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen minimized: WINFORMS_FORM_WINDOW_STATE is
		external
			"IL enum signature :System.Windows.Forms.FormWindowState use System.Windows.Forms.FormWindowState"
		alias
			"1"
		end

	frozen maximized: WINFORMS_FORM_WINDOW_STATE is
		external
			"IL enum signature :System.Windows.Forms.FormWindowState use System.Windows.Forms.FormWindowState"
		alias
			"2"
		end

	frozen normal: WINFORMS_FORM_WINDOW_STATE is
		external
			"IL enum signature :System.Windows.Forms.FormWindowState use System.Windows.Forms.FormWindowState"
		alias
			"0"
		end

end -- class WINFORMS_FORM_WINDOW_STATE
