indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeThrowExceptionStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_THROW_EXCEPTION_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_throw_exception_statement_1,
	make_system_dll_code_throw_exception_statement

feature {NONE} -- Initialization

	frozen make_system_dll_code_throw_exception_statement_1 (to_throw: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeThrowExceptionStatement"
		end

	frozen make_system_dll_code_throw_exception_statement is
		external
			"IL creator use System.CodeDom.CodeThrowExceptionStatement"
		end

feature -- Access

	frozen get_to_throw: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeThrowExceptionStatement"
		alias
			"get_ToThrow"
		end

feature -- Element Change

	frozen set_to_throw (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeThrowExceptionStatement"
		alias
			"set_ToThrow"
		end

end -- class SYSTEM_DLL_CODE_THROW_EXCEPTION_STATEMENT
