indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ToolBarButtonStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONSTYLE

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

	frozen push_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ToolBarButtonStyle use System.Windows.Forms.ToolBarButtonStyle"
		alias
			"1"
		end

	frozen drop_down_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ToolBarButtonStyle use System.Windows.Forms.ToolBarButtonStyle"
		alias
			"4"
		end

	frozen toggle_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ToolBarButtonStyle use System.Windows.Forms.ToolBarButtonStyle"
		alias
			"2"
		end

	frozen separator: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ToolBarButtonStyle use System.Windows.Forms.ToolBarButtonStyle"
		alias
			"3"
		end

end -- class SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONSTYLE
