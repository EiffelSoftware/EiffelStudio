indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.VerificationException"

external class
	SYSTEM_SECURITY_VERIFICATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_verificationexception,
	make_verificationexception_2,
	make_verificationexception_1

feature {NONE} -- Initialization

	frozen make_verificationexception is
		external
			"IL creator use System.Security.VerificationException"
		end

	frozen make_verificationexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.VerificationException"
		end

	frozen make_verificationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Security.VerificationException"
		end

end -- class SYSTEM_SECURITY_VERIFICATIONEXCEPTION
