indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LinkLabel+Link"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LINK_IN_WINFORMS_LINK_LABEL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_link_data: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.LinkLabel+Link"
		alias
			"get_LinkData"
		end

	frozen get_visited: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel+Link"
		alias
			"get_Visited"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkLabel+Link"
		alias
			"get_Length"
		end

	frozen get_start: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkLabel+Link"
		alias
			"get_Start"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel+Link"
		alias
			"get_Enabled"
		end

feature -- Element Change

	frozen set_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.LinkLabel+Link"
		alias
			"set_Length"
		end

	frozen set_link_data (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.LinkLabel+Link"
		alias
			"set_LinkData"
		end

	frozen set_start (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.LinkLabel+Link"
		alias
			"set_Start"
		end

	frozen set_visited (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.LinkLabel+Link"
		alias
			"set_Visited"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.LinkLabel+Link"
		alias
			"set_Enabled"
		end

end -- class WINFORMS_LINK_IN_WINFORMS_LINK_LABEL
