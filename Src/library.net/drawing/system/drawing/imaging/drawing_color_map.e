indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ColorMap"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_COLOR_MAP

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Imaging.ColorMap"
		end

feature -- Access

	frozen get_new_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Imaging.ColorMap"
		alias
			"get_NewColor"
		end

	frozen get_old_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Imaging.ColorMap"
		alias
			"get_OldColor"
		end

feature -- Element Change

	frozen set_new_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Imaging.ColorMap"
		alias
			"set_NewColor"
		end

	frozen set_old_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Imaging.ColorMap"
		alias
			"set_OldColor"
		end

end -- class DRAWING_COLOR_MAP
