indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.IndentedTextWriter"

external class
	SYSTEM_CODEDOM_COMPILER_INDENTEDTEXTWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		redefine
			write_line_string_array_object,
			write_line_string_object_object,
			write_line_string_object,
			write_line_object,
			write_line_string,
			write_line_double,
			write_line_single,
			write_line_int64,
			write_line_int32,
			write_line_boolean,
			write_line_array_char_int32,
			write_line_array_char,
			write_line_char,
			write_line,
			write_string_array_object,
			write_string_object_object,
			write_string_object,
			write_object,
			write_string,
			write_double,
			write_single,
			write,
			write_int32,
			write_boolean,
			write_array_char_int32,
			write_array_char,
			write_char,
			set_new_line,
			get_new_line,
			flush,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_indentedtextwriter_1,
	make_indentedtextwriter

feature {NONE} -- Initialization

	frozen make_indentedtextwriter_1 (writer: SYSTEM_IO_TEXTWRITER; tab_string: STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.CodeDom.Compiler.IndentedTextWriter"
		end

	frozen make_indentedtextwriter (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.CodeDom.Compiler.IndentedTextWriter"
		end

feature -- Access

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"get_Encoding"
		end

	frozen get_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"get_Indent"
		end

	frozen get_inner_writer: SYSTEM_IO_TEXTWRITER is
		external
			"IL signature (): System.IO.TextWriter use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"get_InnerWriter"
		end

	get_new_line: STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"get_NewLine"
		end

feature -- Element Change

	set_new_line (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"set_NewLine"
		end

	frozen set_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"set_Indent"
		end

feature -- Basic Operations

	write_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	flush is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Flush"
		end

	write_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_string_object (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_string_array_object (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	frozen write_line_no_tabs (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLineNoTabs"
		end

	write (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_string_array_object (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_object (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_int64 (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_string (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_string (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_string_object_object (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_object (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_string_object_object (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Close"
		end

	write_string_object (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

feature {NONE} -- Implementation

	output_tabs is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"OutputTabs"
		end

end -- class SYSTEM_CODEDOM_COMPILER_INDENTEDTEXTWRITER
