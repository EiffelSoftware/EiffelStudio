indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.CryptographicUnexpectedOperationException"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOGRAPHICUNEXPECTEDOPERATIONEXCEPTION

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOGRAPHICEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_cryptographicunexpectedoperationexception,
	make_cryptographicunexpectedoperationexception_2,
	make_cryptographicunexpectedoperationexception_3,
	make_cryptographicunexpectedoperationexception_1

feature {NONE} -- Initialization

	frozen make_cryptographicunexpectedoperationexception is
		external
			"IL creator use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

	frozen make_cryptographicunexpectedoperationexception_2 (format: STRING; insert: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

	frozen make_cryptographicunexpectedoperationexception_3 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

	frozen make_cryptographicunexpectedoperationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_CRYPTOGRAPHICUNEXPECTEDOPERATIONEXCEPTION
