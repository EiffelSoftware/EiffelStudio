indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.CSharp.CompilerError"
	assembly: "cscompmgd", "7.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	CS_COMPILER_ERROR

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Microsoft.CSharp.CompilerError"
		end

feature -- Access

	frozen error_level: CS_ERROR_LEVEL is
		external
			"IL field signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.CompilerError"
		alias
			"ErrorLevel"
		end

	frozen error_message: SYSTEM_STRING is
		external
			"IL field signature :System.String use Microsoft.CSharp.CompilerError"
		alias
			"ErrorMessage"
		end

	frozen source_file: SYSTEM_STRING is
		external
			"IL field signature :System.String use Microsoft.CSharp.CompilerError"
		alias
			"SourceFile"
		end

	frozen error_number: INTEGER is
		external
			"IL field signature :System.Int32 use Microsoft.CSharp.CompilerError"
		alias
			"ErrorNumber"
		end

	frozen source_column: INTEGER is
		external
			"IL field signature :System.Int32 use Microsoft.CSharp.CompilerError"
		alias
			"SourceColumn"
		end

	frozen source_line: INTEGER is
		external
			"IL field signature :System.Int32 use Microsoft.CSharp.CompilerError"
		alias
			"SourceLine"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Microsoft.CSharp.CompilerError"
		alias
			"ToString"
		end

end -- class CS_COMPILER_ERROR
