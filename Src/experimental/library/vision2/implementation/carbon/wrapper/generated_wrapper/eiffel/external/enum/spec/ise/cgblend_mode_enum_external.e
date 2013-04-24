-- enum wrapper
class CGBLEND_MODE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgblendmodenormal or a_value = kcgblendmodemultiply or a_value = kcgblendmodescreen or a_value = kcgblendmodeoverlay or a_value = kcgblendmodedarken or a_value = kcgblendmodelighten or a_value = kcgblendmodecolordodge or a_value = kcgblendmodecolorburn or a_value = kcgblendmodesoftlight or a_value = kcgblendmodehardlight or a_value = kcgblendmodedifference or a_value = kcgblendmodeexclusion or a_value = kcgblendmodehue or a_value = kcgblendmodesaturation or a_value = kcgblendmodecolor or a_value = kcgblendmodeluminosity
		end

	 frozen kcgblendmodenormal: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeNormal"
		end

	 frozen kcgblendmodemultiply: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeMultiply"
		end

	 frozen kcgblendmodescreen: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeScreen"
		end

	 frozen kcgblendmodeoverlay: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeOverlay"
		end

	 frozen kcgblendmodedarken: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeDarken"
		end

	 frozen kcgblendmodelighten: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeLighten"
		end

	 frozen kcgblendmodecolordodge: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeColorDodge"
		end

	 frozen kcgblendmodecolorburn: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeColorBurn"
		end

	 frozen kcgblendmodesoftlight: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeSoftLight"
		end

	 frozen kcgblendmodehardlight: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeHardLight"
		end

	 frozen kcgblendmodedifference: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeDifference"
		end

	 frozen kcgblendmodeexclusion: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeExclusion"
		end

	 frozen kcgblendmodehue: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeHue"
		end

	 frozen kcgblendmodesaturation: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeSaturation"
		end

	 frozen kcgblendmodecolor: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeColor"
		end

	 frozen kcgblendmodeluminosity: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGBlendModeLuminosity"
		end

end
