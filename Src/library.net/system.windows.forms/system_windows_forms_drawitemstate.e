indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DrawItemState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE

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

	frozen no_accelerator: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"256"
		end

	frozen grayed: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"2"
		end

	frozen focus: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"16"
		end

	frozen no_focus_rect: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"512"
		end

	frozen hot_light: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"64"
		end

	frozen default: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"32"
		end

	frozen selected: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"1"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"0"
		end

	frozen disabled: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"4"
		end

	frozen combo_box_edit: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"4096"
		end

	frozen inactive: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"128"
		end

	frozen checked: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL enum signature :System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemState"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE
