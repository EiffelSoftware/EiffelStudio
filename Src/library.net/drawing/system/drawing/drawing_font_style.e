indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.FontStyle"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_FONT_STYLE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen underline: DRAWING_FONT_STYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"4"
		end

	frozen regular: DRAWING_FONT_STYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"0"
		end

	frozen strikeout: DRAWING_FONT_STYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"8"
		end

	frozen bold: DRAWING_FONT_STYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"1"
		end

	frozen italic: DRAWING_FONT_STYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DRAWING_FONT_STYLE
