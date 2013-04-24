-- enum wrapper
class CFSTRING_NORMALIZATION_FORM_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcfstringnormalizationformd or a_value = kcfstringnormalizationformkd or a_value = kcfstringnormalizationformc or a_value = kcfstringnormalizationformkc
		end

	 frozen kcfstringnormalizationformd: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStringNormalizationFormD"
		end

	 frozen kcfstringnormalizationformkd: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStringNormalizationFormKD"
		end

	 frozen kcfstringnormalizationformc: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStringNormalizationFormC"
		end

	 frozen kcfstringnormalizationformkc: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStringNormalizationFormKC"
		end

end
