indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.EvaluateException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_EVALUATE_EXCEPTION

inherit
	DATA_INVALID_EXPRESSION_EXCEPTION
	ISERIALIZABLE

create
	make_data_evaluate_exception_1,
	make_data_evaluate_exception

feature {NONE} -- Initialization

	frozen make_data_evaluate_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.EvaluateException"
		end

	frozen make_data_evaluate_exception is
		external
			"IL creator use System.Data.EvaluateException"
		end

end -- class DATA_EVALUATE_EXCEPTION
