-- enum wrapper
class CGTEXT_DRAWING_MODE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgtextfill or a_value = kcgtextstroke or a_value = kcgtextfillstroke or a_value = kcgtextinvisible or a_value = kcgtextfillclip or a_value = kcgtextstrokeclip or a_value = kcgtextfillstrokeclip or a_value = kcgtextclip
		end

	 frozen kcgtextfill: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextFill"
		end

	 frozen kcgtextstroke: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextStroke"
		end

	 frozen kcgtextfillstroke: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextFillStroke"
		end

	 frozen kcgtextinvisible: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextInvisible"
		end

	 frozen kcgtextfillclip: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextFillClip"
		end

	 frozen kcgtextstrokeclip: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextStrokeClip"
		end

	 frozen kcgtextfillstrokeclip: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextFillStrokeClip"
		end

	 frozen kcgtextclip: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGTextClip"
		end

end
