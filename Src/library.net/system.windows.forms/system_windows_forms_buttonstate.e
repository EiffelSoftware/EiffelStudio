indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ButtonState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_BUTTONSTATE

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

	frozen All_: SYSTEM_WINDOWS_FORMS_BUTTONSTATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"18176"
		end

	frozen flat: SYSTEM_WINDOWS_FORMS_BUTTONSTATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"16384"
		end

	frozen checked: SYSTEM_WINDOWS_FORMS_BUTTONSTATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"1024"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_BUTTONSTATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"0"
		end

	frozen pushed: SYSTEM_WINDOWS_FORMS_BUTTONSTATE is
		external
			"IL enum signature :System.Windows.Forms.ButtonState use System.Windows.Forms.ButtonState"
		alias
			"512"
		end

	frozen inactive: SYSTEM_WINDOWS_FORMS_BUTTONSTATE is
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

end -- class SYSTEM_WINDOWS_FORMS_BUTTONSTATE
