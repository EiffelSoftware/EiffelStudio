indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.CoordinateSpace"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE

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

	frozen world: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE is
		external
			"IL enum signature :System.Drawing.Drawing2D.CoordinateSpace use System.Drawing.Drawing2D.CoordinateSpace"
		alias
			"0"
		end

	frozen device: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE is
		external
			"IL enum signature :System.Drawing.Drawing2D.CoordinateSpace use System.Drawing.Drawing2D.CoordinateSpace"
		alias
			"2"
		end

	frozen page: SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE is
		external
			"IL enum signature :System.Drawing.Drawing2D.CoordinateSpace use System.Drawing.Drawing2D.CoordinateSpace"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_COORDINATESPACE
