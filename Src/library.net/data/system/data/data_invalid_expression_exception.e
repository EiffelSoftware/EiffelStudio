indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.InvalidExpressionException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_INVALID_EXPRESSION_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_invalid_expression_exception,
	make_data_invalid_expression_exception_1

feature {NONE} -- Initialization

	frozen make_data_invalid_expression_exception is
		external
			"IL creator use System.Data.InvalidExpressionException"
		end

	frozen make_data_invalid_expression_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.InvalidExpressionException"
		end

end -- class DATA_INVALID_EXPRESSION_EXCEPTION
