indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeGotoStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_GOTO_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_goto_statement

feature {NONE} -- Initialization

	frozen make_system_dll_code_goto_statement (label: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeGotoStatement"
		end

feature -- Access

	frozen get_label: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeGotoStatement"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_label (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeGotoStatement"
		alias
			"set_Label"
		end

end -- class SYSTEM_DLL_CODE_GOTO_STATEMENT
