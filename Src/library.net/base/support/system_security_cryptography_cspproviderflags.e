indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.CspProviderFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPROVIDERFLAGS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen use_default_key_container: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPROVIDERFLAGS is
		external
			"IL enum signature :System.Security.Cryptography.CspProviderFlags use System.Security.Cryptography.CspProviderFlags"
		alias
			"2"
		end

	frozen use_machine_key_store: SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPROVIDERFLAGS is
		external
			"IL enum signature :System.Security.Cryptography.CspProviderFlags use System.Security.Cryptography.CspProviderFlags"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_CSPPROVIDERFLAGS
