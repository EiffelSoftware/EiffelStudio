indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.ColorBlend"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_COLOR_BLEND

inherit
	SYSTEM_OBJECT

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

	frozen get_colors: NATIVE_ARRAY [DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Drawing2D.ColorBlend"
		alias
			"get_Colors"
		end

	frozen get_positions: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Drawing2D.ColorBlend"
		alias
			"get_Positions"
		end

feature -- Element Change

	frozen set_colors (value: NATIVE_ARRAY [DRAWING_COLOR]) is
		external
			"IL signature (System.Drawing.Color[]): System.Void use System.Drawing.Drawing2D.ColorBlend"
		alias
			"set_Colors"
		end

	frozen set_positions (value: NATIVE_ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use System.Drawing.Drawing2D.ColorBlend"
		alias
			"set_Positions"
		end

end -- class DRAWING_COLOR_BLEND
