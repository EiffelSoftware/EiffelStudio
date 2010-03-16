-- enum wrapper
class CGPATH_ELEMENT_TYPE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgpathelementmovetopoint or a_value = kcgpathelementaddlinetopoint or a_value = kcgpathelementaddquadcurvetopoint or a_value = kcgpathelementaddcurvetopoint or a_value = kcgpathelementclosesubpath
		end

	 frozen kcgpathelementmovetopoint: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathElementMoveToPoint"
		end

	 frozen kcgpathelementaddlinetopoint: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathElementAddLineToPoint"
		end

	 frozen kcgpathelementaddquadcurvetopoint: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathElementAddQuadCurveToPoint"
		end

	 frozen kcgpathelementaddcurvetopoint: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathElementAddCurveToPoint"
		end

	 frozen kcgpathelementclosesubpath: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGPathElementCloseSubpath"
		end

end
