indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CspParameters"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CSP_PARAMETERS

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (dw_type_in: INTEGER; str_provider_name_in: SYSTEM_STRING; str_container_name_in: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String, System.String) use System.Security.Cryptography.CspParameters"
		end

	frozen make_2 (dw_type_in: INTEGER; str_provider_name_in: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Security.Cryptography.CspParameters"
		end

	frozen make is
		external
			"IL creator use System.Security.Cryptography.CspParameters"
		end

	frozen make_1 (dw_type_in: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.CspParameters"
		end

feature -- Access

	frozen provider_type: INTEGER is
		external
			"IL field signature :System.Int32 use System.Security.Cryptography.CspParameters"
		alias
			"ProviderType"
		end

	frozen get_flags: CSP_PROVIDER_FLAGS is
		external
			"IL signature (): System.Security.Cryptography.CspProviderFlags use System.Security.Cryptography.CspParameters"
		alias
			"get_Flags"
		end

	frozen provider_name: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Security.Cryptography.CspParameters"
		alias
			"ProviderName"
		end

	frozen key_number: INTEGER is
		external
			"IL field signature :System.Int32 use System.Security.Cryptography.CspParameters"
		alias
			"KeyNumber"
		end

	frozen key_container_name: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Security.Cryptography.CspParameters"
		alias
			"KeyContainerName"
		end

feature -- Element Change

	frozen set_flags (value: CSP_PROVIDER_FLAGS) is
		external
			"IL signature (System.Security.Cryptography.CspProviderFlags): System.Void use System.Security.Cryptography.CspParameters"
		alias
			"set_Flags"
		end

end -- class CSP_PARAMETERS
