indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.PenType"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_PEN_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen linear_gradient: DRAWING_PEN_TYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"4"
		end

	frozen solid_color: DRAWING_PEN_TYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"0"
		end

	frozen texture_fill: DRAWING_PEN_TYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"2"
		end

	frozen path_gradient: DRAWING_PEN_TYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"3"
		end

	frozen hatch_fill: DRAWING_PEN_TYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"1"
		end

end -- class DRAWING_PEN_TYPE
