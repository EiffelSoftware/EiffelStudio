indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.LineJoin"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_DRAWING2D_LINEJOIN

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

	frozen round: SYSTEM_DRAWING_DRAWING2D_LINEJOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"2"
		end

	frozen miter: SYSTEM_DRAWING_DRAWING2D_LINEJOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"0"
		end

	frozen miter_clipped: SYSTEM_DRAWING_DRAWING2D_LINEJOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"3"
		end

	frozen bevel: SYSTEM_DRAWING_DRAWING2D_LINEJOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_LINEJOIN
