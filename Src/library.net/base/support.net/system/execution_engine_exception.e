indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ExecutionEngineException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	EXECUTION_ENGINE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_execution_engine_exception,
	make_execution_engine_exception_2,
	make_execution_engine_exception_1

feature {NONE} -- Initialization

	frozen make_execution_engine_exception is
		external
			"IL creator use System.ExecutionEngineException"
		end

	frozen make_execution_engine_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ExecutionEngineException"
		end

	frozen make_execution_engine_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ExecutionEngineException"
		end

end -- class EXECUTION_ENGINE_EXCEPTION
