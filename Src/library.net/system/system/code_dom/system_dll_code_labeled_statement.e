indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeLabeledStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_LABELED_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_labeled_statement,
	make_system_dll_code_labeled_statement_2,
	make_system_dll_code_labeled_statement_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_labeled_statement is
		external
			"IL creator use System.CodeDom.CodeLabeledStatement"
		end

	frozen make_system_dll_code_labeled_statement_2 (label: SYSTEM_STRING; statement: SYSTEM_DLL_CODE_STATEMENT) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeStatement) use System.CodeDom.CodeLabeledStatement"
		end

	frozen make_system_dll_code_labeled_statement_1 (label: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeLabeledStatement"
		end

feature -- Access

	frozen get_statement: SYSTEM_DLL_CODE_STATEMENT is
		external
			"IL signature (): System.CodeDom.CodeStatement use System.CodeDom.CodeLabeledStatement"
		alias
			"get_Statement"
		end

	frozen get_label: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeLabeledStatement"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_label (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeLabeledStatement"
		alias
			"set_Label"
		end

	frozen set_statement (value: SYSTEM_DLL_CODE_STATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeLabeledStatement"
		alias
			"set_Statement"
		end

end -- class SYSTEM_DLL_CODE_LABELED_STATEMENT
