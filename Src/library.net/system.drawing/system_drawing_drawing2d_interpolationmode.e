indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.InterpolationMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen invalid: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"-1"
		end

	frozen nearest_neighbor: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"5"
		end

	frozen bicubic: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"4"
		end

	frozen high: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"2"
		end

	frozen bilinear: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"3"
		end

	frozen high_quality_bilinear: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"6"
		end

	frozen default: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"0"
		end

	frozen high_quality_bicubic: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"7"
		end

	frozen low: SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Drawing2D.InterpolationMode"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_INTERPOLATIONMODE
