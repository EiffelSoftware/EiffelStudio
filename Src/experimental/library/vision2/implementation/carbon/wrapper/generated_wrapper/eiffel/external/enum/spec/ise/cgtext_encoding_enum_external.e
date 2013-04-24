-- enum wrapper
class CGTEXT_ENCODING_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgencodingfontspecific or a_value = kcgencodingmacroman
		end

	 frozen kcgencodingfontspecific: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGEncodingFontSpecific"
		end

	 frozen kcgencodingmacroman: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGEncodingMacRoman"
		end

end
