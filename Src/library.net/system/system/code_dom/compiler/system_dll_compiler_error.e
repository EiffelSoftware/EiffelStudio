indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CompilerError"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPILER_ERROR

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.CodeDom.Compiler.CompilerError"
		end

	frozen make_1 (file_name: SYSTEM_STRING; line: INTEGER; column: INTEGER; error_number: SYSTEM_STRING; error_text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.String, System.String) use System.CodeDom.Compiler.CompilerError"
		end

feature -- Access

	frozen get_column: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CompilerError"
		alias
			"get_Column"
		end

	frozen get_is_warning: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerError"
		alias
			"get_IsWarning"
		end

	frozen get_error_number: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerError"
		alias
			"get_ErrorNumber"
		end

	frozen get_line: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CompilerError"
		alias
			"get_Line"
		end

	frozen get_error_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerError"
		alias
			"get_ErrorText"
		end

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerError"
		alias
			"get_FileName"
		end

feature -- Element Change

	frozen set_column (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.CompilerError"
		alias
			"set_Column"
		end

	frozen set_is_warning (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.CompilerError"
		alias
			"set_IsWarning"
		end

	frozen set_line (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.CompilerError"
		alias
			"set_Line"
		end

	frozen set_error_number (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerError"
		alias
			"set_ErrorNumber"
		end

	frozen set_file_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerError"
		alias
			"set_FileName"
		end

	frozen set_error_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CompilerError"
		alias
			"set_ErrorText"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CompilerError"
		alias
			"ToString"
		end

end -- class SYSTEM_DLL_COMPILER_ERROR
