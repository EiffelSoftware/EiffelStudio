indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeAssignStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ASSIGN_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_assign_statement,
	make_system_dll_code_assign_statement_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_assign_statement is
		external
			"IL creator use System.CodeDom.CodeAssignStatement"
		end

	frozen make_system_dll_code_assign_statement_1 (left: SYSTEM_DLL_CODE_EXPRESSION; right: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeExpression) use System.CodeDom.CodeAssignStatement"
		end

feature -- Access

	frozen get_right: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAssignStatement"
		alias
			"get_Right"
		end

	frozen get_left: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeAssignStatement"
		alias
			"get_Left"
		end

feature -- Element Change

	frozen set_right (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAssignStatement"
		alias
			"set_Right"
		end

	frozen set_left (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeAssignStatement"
		alias
			"set_Left"
		end

end -- class SYSTEM_DLL_CODE_ASSIGN_STATEMENT
