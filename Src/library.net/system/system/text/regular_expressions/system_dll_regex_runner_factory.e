indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.RegexRunnerFactory"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_REGEX_RUNNER_FACTORY

inherit
	SYSTEM_OBJECT

feature {NONE} -- Implementation

	create_instance: SYSTEM_DLL_REGEX_RUNNER is
		external
			"IL deferred signature (): System.Text.RegularExpressions.RegexRunner use System.Text.RegularExpressions.RegexRunnerFactory"
		alias
			"CreateInstance"
		end

end -- class SYSTEM_DLL_REGEX_RUNNER_FACTORY
