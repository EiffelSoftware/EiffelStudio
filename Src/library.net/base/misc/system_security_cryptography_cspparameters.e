indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.CspParameters"

frozen external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (dw_type_in: INTEGER; str_provider_name_in: STRING; str_container_name_in: STRING) is
		external
			"IL creator signature (System.Int32, System.String, System.String) use System.Security.Cryptography.CspParameters"
		end

	frozen make_2 (dw_type_in: INTEGER; str_provider_name_in: STRING) is
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

	frozen get_flags: INTEGER is
		external
			"IL signature (): enum System.Security.Cryptography.CspProviderFlags use System.Security.Cryptography.CspParameters"
		alias
			"get_Flags"
		ensure
			valid_csp_provider_flags: Result = 1 or Result = 2
		end

	frozen provider_name: STRING is
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

	frozen key_container_name: STRING is
		external
			"IL field signature :System.String use System.Security.Cryptography.CspParameters"
		alias
			"KeyContainerName"
		end

feature -- Element Change

	frozen set_flags (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- UseMachineKeyStore = 1
			-- UseDefaultKeyContainer = 2
		require
			valid_csp_provider_flags: (1 + 2) & value = 1 + 2
		external
			"IL signature (enum System.Security.Cryptography.CspProviderFlags): System.Void use System.Security.Cryptography.CspParameters"
		alias
			"set_Flags"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPARAMETERS
