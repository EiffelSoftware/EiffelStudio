indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.LineJoin"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_LINE_JOIN

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen round: DRAWING_LINE_JOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"2"
		end

	frozen miter: DRAWING_LINE_JOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"0"
		end

	frozen miter_clipped: DRAWING_LINE_JOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"3"
		end

	frozen bevel: DRAWING_LINE_JOIN is
		external
			"IL enum signature :System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.LineJoin"
		alias
			"1"
		end

end -- class DRAWING_LINE_JOIN
