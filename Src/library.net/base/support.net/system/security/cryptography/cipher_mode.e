indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CipherMode"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CIPHER_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen ecb: CIPHER_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CipherMode use System.Security.Cryptography.CipherMode"
		alias
			"2"
		end

	frozen cbc: CIPHER_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CipherMode use System.Security.Cryptography.CipherMode"
		alias
			"1"
		end

	frozen cts: CIPHER_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CipherMode use System.Security.Cryptography.CipherMode"
		alias
			"5"
		end

	frozen ofb: CIPHER_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CipherMode use System.Security.Cryptography.CipherMode"
		alias
			"3"
		end

	frozen cfb: CIPHER_MODE is
		external
			"IL enum signature :System.Security.Cryptography.CipherMode use System.Security.Cryptography.CipherMode"
		alias
			"4"
		end

end -- class CIPHER_MODE
