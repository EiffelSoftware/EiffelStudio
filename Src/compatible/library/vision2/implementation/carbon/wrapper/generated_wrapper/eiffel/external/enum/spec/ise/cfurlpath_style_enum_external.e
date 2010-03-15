-- enum wrapper
class CFURLPATH_STYLE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcfurlposixpathstyle or a_value = kcfurlhfspathstyle or a_value = kcfurlwindowspathstyle
		end

	 frozen kcfurlposixpathstyle: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLPOSIXPathStyle"
		end

	 frozen kcfurlhfspathstyle: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLHFSPathStyle"
		end

	 frozen kcfurlwindowspathstyle: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLWindowsPathStyle"
		end

end
