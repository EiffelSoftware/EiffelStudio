indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.StringFormatFlags"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_STRING_FORMAT_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen no_font_fallback: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"1024"
		end

	frozen line_limit: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"8192"
		end

	frozen direction_right_to_left: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"1"
		end

	frozen direction_vertical: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"2"
		end

	frozen fit_black_box: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"4"
		end

	frozen no_clip: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"16384"
		end

	frozen display_format_control: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"32"
		end

	frozen measure_trailing_spaces: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"2048"
		end

	frozen no_wrap: DRAWING_STRING_FORMAT_FLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"4096"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DRAWING_STRING_FORMAT_FLAGS
