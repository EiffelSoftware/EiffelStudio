indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TickStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_TICKSTYLE

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

	frozen both: SYSTEM_WINDOWS_FORMS_TICKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.TickStyle use System.Windows.Forms.TickStyle"
		alias
			"3"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_TICKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.TickStyle use System.Windows.Forms.TickStyle"
		alias
			"0"
		end

	frozen top_left: SYSTEM_WINDOWS_FORMS_TICKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.TickStyle use System.Windows.Forms.TickStyle"
		alias
			"1"
		end

	frozen bottom_right: SYSTEM_WINDOWS_FORMS_TICKSTYLE is
		external
			"IL enum signature :System.Windows.Forms.TickStyle use System.Windows.Forms.TickStyle"
		alias
			"2"
		end

end -- class SYSTEM_WINDOWS_FORMS_TICKSTYLE
