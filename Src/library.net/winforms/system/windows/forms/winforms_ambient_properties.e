indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AmbientProperties"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_AMBIENT_PROPERTIES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Windows.Forms.AmbientProperties"
		end

feature -- Access

	frozen get_cursor: WINFORMS_CURSOR is
		external
			"IL signature (): System.Windows.Forms.Cursor use System.Windows.Forms.AmbientProperties"
		alias
			"get_Cursor"
		end

	frozen get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.AmbientProperties"
		alias
			"get_ForeColor"
		end

	frozen get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.AmbientProperties"
		alias
			"get_Font"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.AmbientProperties"
		alias
			"get_BackColor"
		end

feature -- Element Change

	frozen set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_Font"
		end

	frozen set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_ForeColor"
		end

	frozen set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_BackColor"
		end

	frozen set_cursor (value: WINFORMS_CURSOR) is
		external
			"IL signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.AmbientProperties"
		alias
			"set_Cursor"
		end

end -- class WINFORMS_AMBIENT_PROPERTIES
