-- enum wrapper
class CFSTREAM_ERROR_DOMAIN_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = kcfstreamerrordomaincustom or a_value = kcfstreamerrordomainposix or a_value = kcfstreamerrordomainmacosstatus
		end

	 frozen kcfstreamerrordomaincustom: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStreamErrorDomainCustom"
		end

	 frozen kcfstreamerrordomainposix: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStreamErrorDomainPOSIX"
		end

	 frozen kcfstreamerrordomainmacosstatus: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"kCFStreamErrorDomainMacOSStatus"
		end

end
