indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.FontStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_FONTSTYLE

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

	frozen underline: SYSTEM_DRAWING_FONTSTYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"4"
		end

	frozen regular: SYSTEM_DRAWING_FONTSTYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"0"
		end

	frozen strikeout: SYSTEM_DRAWING_FONTSTYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"8"
		end

	frozen bold: SYSTEM_DRAWING_FONTSTYLE is
		external
			"IL enum signature :System.Drawing.FontStyle use System.Drawing.FontStyle"
		alias
			"1"
		end

	frozen italic: SYSTEM_DRAWING_FONTSTYLE is
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

end -- class SYSTEM_DRAWING_FONTSTYLE
