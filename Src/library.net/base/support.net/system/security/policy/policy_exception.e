indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.PolicyException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	POLICY_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_policy_exception_1,
	make_policy_exception_2,
	make_policy_exception

feature {NONE} -- Initialization

	frozen make_policy_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Policy.PolicyException"
		end

	frozen make_policy_exception_2 (message: SYSTEM_STRING; exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.Policy.PolicyException"
		end

	frozen make_policy_exception is
		external
			"IL creator use System.Security.Policy.PolicyException"
		end

end -- class POLICY_EXCEPTION
