-- enum wrapper
class CFSTRING_COMPARE_FLAGS_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcfcomparecaseinsensitive or a_value = kcfcomparebackwards or a_value = kcfcompareanchored or a_value = kcfcomparenonliteral or a_value = kcfcomparelocalized or a_value = kcfcomparenumerically
		end

	 frozen kcfcomparecaseinsensitive: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareCaseInsensitive"
		end

	 frozen kcfcomparebackwards: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareBackwards"
		end

	 frozen kcfcompareanchored: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareAnchored"
		end

	 frozen kcfcomparenonliteral: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareNonliteral"
		end

	 frozen kcfcomparelocalized: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareLocalized"
		end

	 frozen kcfcomparenumerically: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareNumerically"
		end

end
