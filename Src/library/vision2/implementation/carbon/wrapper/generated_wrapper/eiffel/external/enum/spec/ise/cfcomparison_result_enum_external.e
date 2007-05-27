-- enum wrapper
class CFCOMPARISON_RESULT_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcfcomparelessthan or a_value = kcfcompareequalto or a_value = kcfcomparegreaterthan
		end

	 frozen kcfcomparelessthan: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareLessThan"
		end

	 frozen kcfcompareequalto: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareEqualTo"
		end

	 frozen kcfcomparegreaterthan: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFCompareGreaterThan"
		end

end
