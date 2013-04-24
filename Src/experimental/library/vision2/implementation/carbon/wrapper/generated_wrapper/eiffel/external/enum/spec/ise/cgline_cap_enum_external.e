-- enum wrapper
class CGLINE_CAP_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcglinecapbutt or a_value = kcglinecapround or a_value = kcglinecapsquare
		end

	 frozen kcglinecapbutt: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGLineCapButt"
		end

	 frozen kcglinecapround: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGLineCapRound"
		end

	 frozen kcglinecapsquare: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGLineCapSquare"
		end

end
