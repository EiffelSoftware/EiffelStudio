indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.KeyPressEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_keypresseventargs

feature {NONE} -- Initialization

	frozen make_keypresseventargs (key_char: CHARACTER) is
		external
			"IL creator signature (System.Char) use System.Windows.Forms.KeyPressEventArgs"
		end

feature -- Access

	frozen get_handled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.KeyPressEventArgs"
		alias
			"get_Handled"
		end

	frozen get_key_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Windows.Forms.KeyPressEventArgs"
		alias
			"get_KeyChar"
		end

feature -- Element Change

	frozen set_handled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.KeyPressEventArgs"
		alias
			"set_Handled"
		end

end -- class SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS
