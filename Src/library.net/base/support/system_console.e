indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Console"

frozen external class
	SYSTEM_CONSOLE

create {NONE}

feature -- Access

	frozen get_in: SYSTEM_IO_TEXTREADER is
		external
			"IL static signature (): System.IO.TextReader use System.Console"
		alias
			"get_In"
		end

	frozen get_error: SYSTEM_IO_TEXTWRITER is
		external
			"IL static signature (): System.IO.TextWriter use System.Console"
		alias
			"get_Error"
		end

	frozen get_out: SYSTEM_IO_TEXTWRITER is
		external
			"IL static signature (): System.IO.TextWriter use System.Console"
		alias
			"get_Out"
		end

feature -- Basic Operations

	frozen put_char (value: CHARACTER) is
		external
			"IL static signature (System.Char): System.Void use System.Console"
		alias
			"Write"
		end

	frozen set_in (new_in: SYSTEM_IO_TEXTREADER) is
		external
			"IL static signature (System.IO.TextReader): System.Void use System.Console"
		alias
			"SetIn"
		end

	frozen put_string_and_line (value: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen open_standard_output_with_size (buffer_size: INTEGER): SYSTEM_IO_STREAM is
		external
			"IL static signature (System.Int32): System.IO.Stream use System.Console"
		alias
			"OpenStandardOutput"
		end

	frozen put_real (value: REAL) is
		external
			"IL static signature (System.Single): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_int64_and_line (value: INTEGER_64) is
		external
			"IL static signature (System.Int64): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL static signature (System.Char[]): System.Void use System.Console"
		alias
			"Write"
		end

	frozen set_out (newOut: SYSTEM_IO_TEXTWRITER) is
		external
			"IL static signature (System.IO.TextWriter): System.Void use System.Console"
		alias
			"SetOut"
		end

	frozen open_standard_error_with_size (buffer_size: INTEGER): SYSTEM_IO_STREAM is
		external
			"IL static signature (System.Int32): System.IO.Stream use System.Console"
		alias
			"OpenStandardError"
		end

	frozen put_line_and_characters_from (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.Int32): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_any (value: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen open_standard_error: SYSTEM_IO_STREAM is
		external
			"IL static signature (): System.IO.Stream use System.Console"
		alias
			"OpenStandardError"
		end

	frozen put_line_and_one_format_string (format: STRING; arg0: ANY) is
		external
			"IL static signature (System.String, System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_three_format_string (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY) is
		external
			"IL static signature (System.String, System.Object, System.Object, System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_one_format_string (format: STRING; arg0: ANY) is
		external
			"IL static signature (System.String, System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_array_char_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.Int32): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_decimal (value: SYSTEM_DECIMAL) is
		external
			"IL static signature (System.Decimal): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_real_and_line (value: REAL) is
		external
			"IL static signature (System.Single): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen new_line is
		external
			"IL static signature (): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen open_standard_input: SYSTEM_IO_STREAM is
		external
			"IL static signature (): System.IO.Stream use System.Console"
		alias
			"OpenStandardInput"
		end

	frozen put_int64 (value: INTEGER_64) is
		external
			"IL static signature (System.Int64): System.Void use System.Console"
		alias
			"Write"
		end

	frozen set_error (newError: SYSTEM_IO_TEXTWRITER) is
		external
			"IL static signature (System.IO.TextWriter): System.Void use System.Console"
		alias
			"SetError"
		end

	frozen put_formatted_array (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL static signature (System.String, System.Object[]): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_two_format_string (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL static signature (System.String, System.Object, System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_decimal_and_line (value: SYSTEM_DECIMAL) is
		external
			"IL static signature (System.Decimal): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_integer_and_line (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_array_char_and_line (buffer: ARRAY [CHARACTER]) is
		external
			"IL static signature (System.Char[]): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_formatted_array_and_line (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL static signature (System.String, System.Object[]): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen open_standard_input_with_size (buffer_size: INTEGER): SYSTEM_IO_STREAM is
		external
			"IL static signature (System.Int32): System.IO.Stream use System.Console"
		alias
			"OpenStandardInput"
		end

	frozen put_integer (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_boolean (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_char_and_line (value: CHARACTER) is
		external
			"IL static signature (System.Char): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen read_line: STRING is
		external
			"IL static signature (): System.String use System.Console"
		alias
			"ReadLine"
		end

	frozen open_standard_output: SYSTEM_IO_STREAM is
		external
			"IL static signature (): System.IO.Stream use System.Console"
		alias
			"OpenStandardOutput"
		end

	frozen put_boolean_and_line (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_double (value: DOUBLE) is
		external
			"IL static signature (System.Double): System.Void use System.Console"
		alias
			"Write"
		end

	frozen put_double_and_line (value: DOUBLE) is
		external
			"IL static signature (System.Double): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_line_and_two_format_string (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL static signature (System.String, System.Object, System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_string (value: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Console"
		alias
			"Write"
		end

	frozen read_integer: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Console"
		alias
			"Read"
		end

	frozen put_any_and_line (value: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen put_line_and_three_format_string (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY) is
		external
			"IL static signature (System.String, System.Object, System.Object, System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

end -- class SYSTEM_CONSOLE
