indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.CSharp.CompilerError"

external class
	MICROSOFT_CSHARP_COMPILERERROR

inherit
	ANY
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

	frozen error_level: MICROSOFT_CSHARP_ERRORLEVEL is
		external
			"IL field signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.CompilerError"
		alias
			"ErrorLevel"
		end

	frozen error_message: STRING is
		external
			"IL field signature :System.String use Microsoft.CSharp.CompilerError"
		alias
			"ErrorMessage"
		end

	frozen source_file: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use Microsoft.CSharp.CompilerError"
		alias
			"ToString"
		end

end -- class MICROSOFT_CSHARP_COMPILERERROR
