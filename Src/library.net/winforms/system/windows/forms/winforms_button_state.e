indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ButtonState"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_BUTTON_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_: WINFORMS_BUTTON_STATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"18176"
		end

	frozen flat: WINFORMS_BUTTON_STATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"16384"
		end

	frozen checked: WINFORMS_BUTTON_STATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"1024"
		end

	frozen normal: WINFORMS_BUTTON_STATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"0"
		end

	frozen pushed: WINFORMS_BUTTON_STATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"512"
		end

	frozen inactive: WINFORMS_BUTTON_STATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"256"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_BUTTON_STATE
