indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.IndentedTextWriter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INDENTED_TEXT_WRITER

inherit
	TEXT_WRITER
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
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_system_dll_indented_text_writer,
	make_system_dll_indented_text_writer_1

feature {NONE} -- Initialization

	frozen make_system_dll_indented_text_writer (writer: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.CodeDom.Compiler.IndentedTextWriter"
		end

	frozen make_system_dll_indented_text_writer_1 (writer: TEXT_WRITER; tab_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.IO.TextWriter, System.String) use System.CodeDom.Compiler.IndentedTextWriter"
		end

feature -- Access

	get_encoding: ENCODING is
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

	frozen get_inner_writer: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"get_InnerWriter"
		end

	get_new_line: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"get_NewLine"
		end

--	frozen default_tab_string: SYSTEM_STRING is "    "

feature -- Element Change

	set_new_line (value: SYSTEM_STRING) is
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

	write_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
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

	write_line_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	frozen write_line_no_tabs (s: SYSTEM_STRING) is
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

	write_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
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

	write_object (value: SYSTEM_OBJECT) is
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

	write_line_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_string (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"Write"
		end

	write_line_string (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_line_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
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

	write_line_object (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.Compiler.IndentedTextWriter"
		alias
			"WriteLine"
		end

	write_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
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

	write_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
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

end -- class SYSTEM_DLL_INDENTED_TEXT_WRITER
