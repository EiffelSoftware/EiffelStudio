indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.FormWindowState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE

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

	frozen minimized: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE is
		external
			"IL enum signature :System.Windows.Forms.FormWindowState use System.Windows.Forms.FormWindowState"
		alias
			"1"
		end

	frozen maximized: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE is
		external
			"IL enum signature :System.Windows.Forms.FormWindowState use System.Windows.Forms.FormWindowState"
		alias
			"2"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE is
		external
			"IL enum signature :System.Windows.Forms.FormWindowState use System.Windows.Forms.FormWindowState"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_FORMWINDOWSTATE
