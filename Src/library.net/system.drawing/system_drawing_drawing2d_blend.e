indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.Blend"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_BLEND

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Drawing2D.Blend"
		end

	frozen make_1 (count: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Drawing.Drawing2D.Blend"
		end

feature -- Access

	frozen get_factors: ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Drawing2D.Blend"
		alias
			"get_Factors"
		end

	frozen get_positions: ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Drawing2D.Blend"
		alias
			"get_Positions"
		end

feature -- Element Change

	frozen set_positions (value: ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use System.Drawing.Drawing2D.Blend"
		alias
			"set_Positions"
		end

	frozen set_factors (value: ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use System.Drawing.Drawing2D.Blend"
		alias
			"set_Factors"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_BLEND
