indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.ColorBlend"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_COLORBLEND

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Drawing2D.ColorBlend"
		end

	frozen make_1 (count: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Drawing.Drawing2D.ColorBlend"
		end

feature -- Access

	frozen get_colors: ARRAY [SYSTEM_DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Drawing2D.ColorBlend"
		alias
			"get_Colors"
		end

	frozen get_positions: ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Drawing2D.ColorBlend"
		alias
			"get_Positions"
		end

feature -- Element Change

	frozen set_colors (value: ARRAY [SYSTEM_DRAWING_COLOR]) is
		external
			"IL signature (System.Drawing.Color[]): System.Void use System.Drawing.Drawing2D.ColorBlend"
		alias
			"set_Colors"
		end

	frozen set_positions (value: ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use System.Drawing.Drawing2D.ColorBlend"
		alias
			"set_Positions"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_COLORBLEND
