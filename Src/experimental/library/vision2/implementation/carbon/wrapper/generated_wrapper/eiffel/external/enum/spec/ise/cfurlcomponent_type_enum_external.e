-- enum wrapper
class CFURLCOMPONENT_TYPE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcfurlcomponentscheme or a_value = kcfurlcomponentnetlocation or a_value = kcfurlcomponentpath or a_value = kcfurlcomponentresourcespecifier or a_value = kcfurlcomponentuser or a_value = kcfurlcomponentpassword or a_value = kcfurlcomponentuserinfo or a_value = kcfurlcomponenthost or a_value = kcfurlcomponentport or a_value = kcfurlcomponentparameterstring or a_value = kcfurlcomponentquery or a_value = kcfurlcomponentfragment
		end

	 frozen kcfurlcomponentscheme: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentScheme"
		end

	 frozen kcfurlcomponentnetlocation: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentNetLocation"
		end

	 frozen kcfurlcomponentpath: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentPath"
		end

	 frozen kcfurlcomponentresourcespecifier: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentResourceSpecifier"
		end

	 frozen kcfurlcomponentuser: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentUser"
		end

	 frozen kcfurlcomponentpassword: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentPassword"
		end

	 frozen kcfurlcomponentuserinfo: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentUserInfo"
		end

	 frozen kcfurlcomponenthost: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentHost"
		end

	 frozen kcfurlcomponentport: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentPort"
		end

	 frozen kcfurlcomponentparameterstring: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentParameterString"
		end

	 frozen kcfurlcomponentquery: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentQuery"
		end

	 frozen kcfurlcomponentfragment: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFURLComponentFragment"
		end

end
