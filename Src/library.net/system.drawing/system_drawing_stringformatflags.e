indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.StringFormatFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_STRINGFORMATFLAGS

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

	frozen no_font_fallback: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"1024"
		end

	frozen line_limit: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"8192"
		end

	frozen direction_right_to_left: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"1"
		end

	frozen direction_vertical: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"2"
		end

	frozen fit_black_box: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"4"
		end

	frozen no_clip: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"16384"
		end

	frozen display_format_control: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"32"
		end

	frozen measure_trailing_spaces: SYSTEM_DRAWING_STRINGFORMATFLAGS is
		external
			"IL enum signature :System.Drawing.StringFormatFlags use System.Drawing.StringFormatFlags"
		alias
			"2048"
		end

	frozen no_wrap: SYSTEM_DRAWING_STRINGFORMATFLAGS is
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

end -- class SYSTEM_DRAWING_STRINGFORMATFLAGS
