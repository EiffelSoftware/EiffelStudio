-- enum wrapper
class CGPATH_DRAWING_MODE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgpathfill or a_value = kcgpatheofill or a_value = kcgpathstroke or a_value = kcgpathfillstroke or a_value = kcgpatheofillstroke
		end

	 frozen kcgpathfill: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathFill"
		end

	 frozen kcgpatheofill: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathEOFill"
		end

	 frozen kcgpathstroke: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathStroke"
		end

	 frozen kcgpathfillstroke: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathFillStroke"
		end

	 frozen kcgpatheofillstroke: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathEOFillStroke"
		end

end
