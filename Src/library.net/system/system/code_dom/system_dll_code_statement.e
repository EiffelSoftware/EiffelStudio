indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_STATEMENT

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_statement

feature {NONE} -- Initialization

	frozen make_system_dll_code_statement is
		external
			"IL creator use System.CodeDom.CodeStatement"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeStatement"
		alias
			"get_LinePragma"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_DLL_CODE_LINE_PRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeStatement"
		alias
			"set_LinePragma"
		end

end -- class SYSTEM_DLL_CODE_STATEMENT
