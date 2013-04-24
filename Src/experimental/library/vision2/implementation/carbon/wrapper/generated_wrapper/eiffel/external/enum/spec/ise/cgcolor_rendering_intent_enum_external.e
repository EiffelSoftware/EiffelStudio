-- enum wrapper
class CGCOLOR_RENDERING_INTENT_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgrenderingintentdefault or a_value = kcgrenderingintentabsolutecolorimetric or a_value = kcgrenderingintentrelativecolorimetric or a_value = kcgrenderingintentperceptual or a_value = kcgrenderingintentsaturation
		end

	 frozen kcgrenderingintentdefault: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGRenderingIntentDefault"
		end

	 frozen kcgrenderingintentabsolutecolorimetric: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGRenderingIntentAbsoluteColorimetric"
		end

	 frozen kcgrenderingintentrelativecolorimetric: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGRenderingIntentRelativeColorimetric"
		end

	 frozen kcgrenderingintentperceptual: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGRenderingIntentPerceptual"
		end

	 frozen kcgrenderingintentsaturation: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGRenderingIntentSaturation"
		end

end
