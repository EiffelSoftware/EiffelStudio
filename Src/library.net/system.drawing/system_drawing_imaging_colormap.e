indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ColorMap"

frozen external class
	SYSTEM_DRAWING_IMAGING_COLORMAP

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Imaging.ColorMap"
		end

feature -- Access

	frozen get_new_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Imaging.ColorMap"
		alias
			"get_NewColor"
		end

	frozen get_old_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Imaging.ColorMap"
		alias
			"get_OldColor"
		end

feature -- Element Change

	frozen set_new_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Imaging.ColorMap"
		alias
			"set_NewColor"
		end

	frozen set_old_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Imaging.ColorMap"
		alias
			"set_OldColor"
		end

end -- class SYSTEM_DRAWING_IMAGING_COLORMAP
