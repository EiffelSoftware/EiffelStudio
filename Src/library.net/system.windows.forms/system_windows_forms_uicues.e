indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UICues"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_UICUES

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

	frozen show_keyboard: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"2"
		end

	frozen show_focus: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"1"
		end

	frozen shown: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"3"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"0"
		end

	frozen change_keyboard: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"8"
		end

	frozen change_focus: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"4"
		end

	frozen changed: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"12"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_WINDOWS_FORMS_UICUES
