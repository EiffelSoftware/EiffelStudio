indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.PenType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_PENTYPE

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

	frozen linear_gradient: SYSTEM_DRAWING_DRAWING2D_PENTYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"4"
		end

	frozen solid_color: SYSTEM_DRAWING_DRAWING2D_PENTYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"0"
		end

	frozen texture_fill: SYSTEM_DRAWING_DRAWING2D_PENTYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"2"
		end

	frozen path_gradient: SYSTEM_DRAWING_DRAWING2D_PENTYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"3"
		end

	frozen hatch_fill: SYSTEM_DRAWING_DRAWING2D_PENTYPE is
		external
			"IL enum signature :System.Drawing.Drawing2D.PenType use System.Drawing.Drawing2D.PenType"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_PENTYPE
