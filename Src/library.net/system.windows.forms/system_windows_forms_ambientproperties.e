indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AmbientProperties"

frozen external class
	SYSTEM_WINDOWS_FORMS_AMBIENTPROPERTIES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Windows.Forms.AmbientProperties"
		end

feature -- Access

	frozen get_cursor: SYSTEM_WINDOWS_FORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.AmbientProperties"
		alias
			"get_Cursor"
		end

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.AmbientProperties"
		alias
			"get_ForeColor"
		end

	frozen get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.AmbientProperties"
		alias
			"get_Font"
		end

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.AmbientProperties"
		alias
			"get_BackColor"
		end

feature -- Element Change

	frozen set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_Font"
		end

	frozen set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_ForeColor"
		end

	frozen set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_BackColor"
		end

	frozen set_cursor (value: SYSTEM_WINDOWS_FORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_Cursor"
		end

end -- class SYSTEM_WINDOWS_FORMS_AMBIENTPROPERTIES
