indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.UICues"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_UICUES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen show_keyboard: WINFORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"2"
		end

	frozen show_focus: WINFORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"1"
		end

	frozen shown: WINFORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"3"
		end

	frozen none: WINFORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"0"
		end

	frozen change_keyboard: WINFORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"8"
		end

	frozen change_focus: WINFORMS_UICUES is
		external
			"IL enum signature :System.Windows.Forms.UICues use System.Windows.Forms.UICues"
		alias
			"4"
		end

	frozen changed: WINFORMS_UICUES is
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

end -- class WINFORMS_UICUES
