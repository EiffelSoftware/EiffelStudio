indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.WarpMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_WARPMODE

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

	frozen perspective: SYSTEM_DRAWING_DRAWING2D_WARPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WarpMode use System.Drawing.Drawing2D.WarpMode"
		alias
			"0"
		end

	frozen bilinear: SYSTEM_DRAWING_DRAWING2D_WARPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WarpMode use System.Drawing.Drawing2D.WarpMode"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_WARPMODE
