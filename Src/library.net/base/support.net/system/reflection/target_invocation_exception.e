indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.TargetInvocationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TARGET_INVOCATION_EXCEPTION

inherit
	APPLICATION_EXCEPTION
	ISERIALIZABLE

create
	make_target_invocation_exception_1,
	make_target_invocation_exception

feature {NONE} -- Initialization

	frozen make_target_invocation_exception_1 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetInvocationException"
		end

	frozen make_target_invocation_exception (inner: EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Reflection.TargetInvocationException"
		end

end -- class TARGET_INVOCATION_EXCEPTION
