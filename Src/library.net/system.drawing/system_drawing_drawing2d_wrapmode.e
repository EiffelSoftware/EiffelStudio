indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.WrapMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_WRAPMODE

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

	frozen tile_flip_y: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.WrapMode"
		alias
			"2"
		end

	frozen tile_flip_x: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.WrapMode"
		alias
			"1"
		end

	frozen tile_flip_xy: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.WrapMode"
		alias
			"3"
		end

	frozen tile: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.WrapMode"
		alias
			"0"
		end

	frozen clamp: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL enum signature :System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.WrapMode"
		alias
			"4"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_WRAPMODE
