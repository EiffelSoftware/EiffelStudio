indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SyntaxErrorException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_SYNTAX_ERROR_EXCEPTION

inherit
	DATA_INVALID_EXPRESSION_EXCEPTION
	ISERIALIZABLE

create
	make_data_syntax_error_exception_1,
	make_data_syntax_error_exception

feature {NONE} -- Initialization

	frozen make_data_syntax_error_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.SyntaxErrorException"
		end

	frozen make_data_syntax_error_exception is
		external
			"IL creator use System.Data.SyntaxErrorException"
		end

end -- class DATA_SYNTAX_ERROR_EXCEPTION
