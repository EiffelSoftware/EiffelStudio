indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CryptographicException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CRYPTOGRAPHIC_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_cryptographic_exception_1,
	make_cryptographic_exception_3,
	make_cryptographic_exception,
	make_cryptographic_exception_2,
	make_cryptographic_exception_4

feature {NONE} -- Initialization

	frozen make_cryptographic_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographic_exception_3 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographic_exception is
		external
			"IL creator use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographic_exception_2 (format: SYSTEM_STRING; insert: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographic_exception_4 (hr: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.CryptographicException"
		end

end -- class CRYPTOGRAPHIC_EXCEPTION
