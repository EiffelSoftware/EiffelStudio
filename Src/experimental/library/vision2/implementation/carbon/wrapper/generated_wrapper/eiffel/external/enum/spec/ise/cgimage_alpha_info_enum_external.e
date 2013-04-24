-- enum wrapper
class CGIMAGE_ALPHA_INFO_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcgimagealphanone or a_value = kcgimagealphapremultipliedlast or a_value = kcgimagealphapremultipliedfirst or a_value = kcgimagealphalast or a_value = kcgimagealphafirst or a_value = kcgimagealphanoneskiplast or a_value = kcgimagealphanoneskipfirst or a_value = kcgimagealphaonly
		end

	 frozen kcgimagealphanone: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaNone"
		end

	 frozen kcgimagealphapremultipliedlast: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaPremultipliedLast"
		end

	 frozen kcgimagealphapremultipliedfirst: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaPremultipliedFirst"
		end

	 frozen kcgimagealphalast: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaLast"
		end

	 frozen kcgimagealphafirst: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaFirst"
		end

	 frozen kcgimagealphanoneskiplast: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaNoneSkipLast"
		end

	 frozen kcgimagealphanoneskipfirst: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaNoneSkipFirst"
		end

	 frozen kcgimagealphaonly: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCGImageAlphaOnly"
		end

end
