indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.CryptographicUnexpectedOperationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CRYPTOGRAPHIC_UNEXPECTED_OPERATION_EXCEPTION

inherit
	CRYPTOGRAPHIC_EXCEPTION
	ISERIALIZABLE

create
	make_cryptographic_unexpected_operation_exception,
	make_cryptographic_unexpected_operation_exception_1,
	make_cryptographic_unexpected_operation_exception_3,
	make_cryptographic_unexpected_operation_exception_2

feature {NONE} -- Initialization

	frozen make_cryptographic_unexpected_operation_exception is
		external
			"IL creator use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

	frozen make_cryptographic_unexpected_operation_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

	frozen make_cryptographic_unexpected_operation_exception_3 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

	frozen make_cryptographic_unexpected_operation_exception_2 (format: SYSTEM_STRING; insert: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Cryptography.CryptographicUnexpectedOperationException"
		end

end -- class CRYPTOGRAPHIC_UNEXPECTED_OPERATION_EXCEPTION
