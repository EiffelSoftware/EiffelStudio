indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.InterpolationMode"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_INTERPOLATION_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen invalid: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"-1"
		end

	frozen nearest_neighbor: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"5"
		end

	frozen bicubic: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"4"
		end

	frozen bilinear: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"3"
		end

	frozen high: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"2"
		end

	frozen high_quality_bilinear: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"6"
		end

	frozen default_: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"0"
		end

	frozen high_quality_bicubic: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"7"
		end

	frozen low: DRAWING_INTERPOLATION_MODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"1"
		end

end -- class DRAWING_INTERPOLATION_MODE
