indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.TargetParameterCountException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TARGET_PARAMETER_COUNT_EXCEPTION

inherit
	APPLICATION_EXCEPTION
	ISERIALIZABLE

create
	make_target_parameter_count_exception_2,
	make_target_parameter_count_exception_1,
	make_target_parameter_count_exception

feature {NONE} -- Initialization

	frozen make_target_parameter_count_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetParameterCountException"
		end

	frozen make_target_parameter_count_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.TargetParameterCountException"
		end

	frozen make_target_parameter_count_exception is
		external
			"IL creator use System.Reflection.TargetParameterCountException"
		end

end -- class TARGET_PARAMETER_COUNT_EXCEPTION
