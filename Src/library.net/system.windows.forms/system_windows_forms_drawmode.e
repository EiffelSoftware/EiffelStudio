indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DrawMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_DRAWMODE

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

	frozen normal: SYSTEM_WINDOWS_FORMS_DRAWMODE is
		external
			"IL enum signature :System.Windows.Forms.DrawMode use System.Windows.Forms.DrawMode"
		alias
			"0"
		end

	frozen owner_draw_variable: SYSTEM_WINDOWS_FORMS_DRAWMODE is
		external
			"IL enum signature :System.Windows.Forms.DrawMode use System.Windows.Forms.DrawMode"
		alias
			"2"
		end

	frozen owner_draw_fixed: SYSTEM_WINDOWS_FORMS_DRAWMODE is
		external
			"IL enum signature :System.Windows.Forms.DrawMode use System.Windows.Forms.DrawMode"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_DRAWMODE
