indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.VerificationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	VERIFICATION_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_verification_exception,
	make_verification_exception_2,
	make_verification_exception_1

feature {NONE} -- Initialization

	frozen make_verification_exception is
		external
			"IL creator use System.Security.VerificationException"
		end

	frozen make_verification_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.VerificationException"
		end

	frozen make_verification_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.VerificationException"
		end

end -- class VERIFICATION_EXCEPTION
