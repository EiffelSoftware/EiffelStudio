indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Console"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_CONSOLE

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_error: TEXT_WRITER is
		external
			"IL static signature (): System.IO.TextWriter use System.Console"
		alias
			"get_Error"
		end

	frozen get_out: TEXT_WRITER is
		external
			"IL static signature (): System.IO.TextWriter use System.Console"
		alias
			"get_Out"
		end

	frozen get_in: TEXT_READER is
		external
			"IL static signature (): System.IO.TextReader use System.Console"
		alias
			"get_In"
		end

feature -- Basic Operations

	frozen write_char (value: CHARACTER) is
		external
			"IL static signature (System.Char): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_double (value: DOUBLE) is
		external
			"IL static signature (System.Double): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line_int64 (value: INTEGER_64) is
		external
			"IL static signature (System.Int64): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen open_standard_input: SYSTEM_STREAM is
		external
			"IL static signature (): System.IO.Stream use System.Console"
		alias
			"OpenStandardInput"
		end

	frozen open_standard_error_int32 (buffer_size: INTEGER): SYSTEM_STREAM is
		external
			"IL static signature (System.Int32): System.IO.Stream use System.Console"
		alias
			"OpenStandardError"
		end

	frozen write_int64 (value: INTEGER_64) is
		external
			"IL static signature (System.Int64): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL static signature (System.String, System.Object[]): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_line_string (value: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL static signature (System.String, System.Object[]): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object, System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen read: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Console"
		alias
			"Read"
		end

	frozen open_standard_output: SYSTEM_STREAM is
		external
			"IL static signature (): System.IO.Stream use System.Console"
		alias
			"OpenStandardOutput"
		end

	frozen write_string (value: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line_string_object_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object, System.Object, System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen open_standard_input_int32 (buffer_size: INTEGER): SYSTEM_STREAM is
		external
			"IL static signature (System.Int32): System.IO.Stream use System.Console"
		alias
			"OpenStandardInput"
		end

	frozen write_single (value: REAL) is
		external
			"IL static signature (System.Single): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write (value: DECIMAL) is
		external
			"IL static signature (System.Decimal): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line is
		external
			"IL static signature (): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_line_single (value: REAL) is
		external
			"IL static signature (System.Single): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_boolean (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Console"
		alias
			"Write"
		end

	frozen set_in (new_in: TEXT_READER) is
		external
			"IL static signature (System.IO.TextReader): System.Void use System.Console"
		alias
			"SetIn"
		end

	frozen write_line_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL static signature (System.Char[]): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object, System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen set_error (new_error: TEXT_WRITER) is
		external
			"IL static signature (System.IO.TextWriter): System.Void use System.Console"
		alias
			"SetError"
		end

	frozen write_line_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_line_char (value: CHARACTER) is
		external
			"IL static signature (System.Char): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.Int32): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_object (value: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line_int32 (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen open_standard_error: SYSTEM_STREAM is
		external
			"IL static signature (): System.IO.Stream use System.Console"
		alias
			"OpenStandardError"
		end

	frozen write_line_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.Int32): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_int32 (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_line_boolean (value: BOOLEAN) is
		external
			"IL static signature (System.Boolean): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL static signature (System.Char[]): System.Void use System.Console"
		alias
			"Write"
		end

	frozen write_string_object_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object, System.Object, System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen open_standard_output_int32 (buffer_size: INTEGER): SYSTEM_STREAM is
		external
			"IL static signature (System.Int32): System.IO.Stream use System.Console"
		alias
			"OpenStandardOutput"
		end

	frozen write_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object): System.Void use System.Console"
		alias
			"Write"
		end

	frozen set_out (new_out: TEXT_WRITER) is
		external
			"IL static signature (System.IO.TextWriter): System.Void use System.Console"
		alias
			"SetOut"
		end

	frozen write_line_decimal (value: DECIMAL) is
		external
			"IL static signature (System.Decimal): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen write_line_double (value: DOUBLE) is
		external
			"IL static signature (System.Double): System.Void use System.Console"
		alias
			"WriteLine"
		end

	frozen read_line: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Console"
		alias
			"ReadLine"
		end

	frozen write_line_object (value: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Console"
		alias
			"WriteLine"
		end

end -- class SYSTEM_CONSOLE
