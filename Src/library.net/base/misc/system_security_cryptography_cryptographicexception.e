indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.CryptographicException"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOGRAPHICEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_cryptographicexception_2,
	make_cryptographicexception_3,
	make_cryptographicexception_1,
	make_cryptographicexception,
	make_cryptographicexception_4

feature {NONE} -- Initialization

	frozen make_cryptographicexception_2 (format: STRING; insert: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographicexception_3 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographicexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographicexception is
		external
			"IL creator use System.Security.Cryptography.CryptographicException"
		end

	frozen make_cryptographicexception_4 (hr: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.Cryptography.CryptographicException"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOGRAPHICEXCEPTION
