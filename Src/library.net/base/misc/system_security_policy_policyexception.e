indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.PolicyException"

external class
	SYSTEM_SECURITY_POLICY_POLICYEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_policyexception_2,
	make_policyexception_1,
	make_policyexception

feature {NONE} -- Initialization

	frozen make_policyexception_2 (message: STRING; exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.Policy.PolicyException"
		end

	frozen make_policyexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Security.Policy.PolicyException"
		end

	frozen make_policyexception is
		external
			"IL creator use System.Security.Policy.PolicyException"
		end

end -- class SYSTEM_SECURITY_POLICY_POLICYEXCEPTION
