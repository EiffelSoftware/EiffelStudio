indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.TargetException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TARGET_EXCEPTION

inherit
	APPLICATION_EXCEPTION
	ISERIALIZABLE

create
	make_target_exception_1,
	make_target_exception_2,
	make_target_exception

feature {NONE} -- Initialization

	frozen make_target_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.TargetException"
		end

	frozen make_target_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetException"
		end

	frozen make_target_exception is
		external
			"IL creator use System.Reflection.TargetException"
		end

end -- class TARGET_EXCEPTION
