indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CspProviderFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CSP_PROVIDER_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen use_default_key_container: CSP_PROVIDER_FLAGS is
		external
			"IL enum signature :System.Security.Cryptography.CspProviderFlags use System.Security.Cryptography.CspProviderFlags"
		alias
			"2"
		end

	frozen use_machine_key_store: CSP_PROVIDER_FLAGS is
		external
			"IL enum signature :System.Security.Cryptography.CspProviderFlags use System.Security.Cryptography.CspProviderFlags"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class CSP_PROVIDER_FLAGS
