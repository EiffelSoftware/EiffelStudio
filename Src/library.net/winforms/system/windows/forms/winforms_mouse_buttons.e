indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MouseButtons"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_MOUSE_BUTTONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen xbutton1: WINFORMS_MOUSE_BUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"8388608"
		end

	frozen xbutton2: WINFORMS_MOUSE_BUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"16777216"
		end

	frozen right: WINFORMS_MOUSE_BUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"2097152"
		end

	frozen left: WINFORMS_MOUSE_BUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"1048576"
		end

	frozen middle: WINFORMS_MOUSE_BUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"4194304"
		end

	frozen none: WINFORMS_MOUSE_BUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_MOUSE_BUTTONS
