-- enum wrapper
class CGINTERPOLATION_QUALITY_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcginterpolationdefault or a_value = kcginterpolationnone or a_value = kcginterpolationlow or a_value = kcginterpolationhigh
		end

	 frozen kcginterpolationdefault: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGInterpolationDefault"
		end

	 frozen kcginterpolationnone: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGInterpolationNone"
		end

	 frozen kcginterpolationlow: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGInterpolationLow"
		end

	 frozen kcginterpolationhigh: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGInterpolationHigh"
		end

end
