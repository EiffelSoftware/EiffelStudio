indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MouseButtons"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS

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

	frozen xbutton1: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"8388608"
		end

	frozen xbutton2: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"16777216"
		end

	frozen right: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"2097152"
		end

	frozen left: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"1048576"
		end

	frozen middle: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL enum signature :System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseButtons"
		alias
			"4194304"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
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

end -- class SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS
