indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.TextWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	TEXT_WRITER

inherit
	MARSHAL_BY_REF_OBJECT
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_encoding: ENCODING is
		external
			"IL deferred signature (): System.Text.Encoding use System.IO.TextWriter"
		alias
			"get_Encoding"
		end

	frozen null: TEXT_WRITER is
		external
			"IL static_field signature :System.IO.TextWriter use System.IO.TextWriter"
		alias
			"Null"
		end

	get_new_line: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.TextWriter"
		alias
			"get_NewLine"
		end

	get_format_provider: IFORMAT_PROVIDER is
		external
			"IL signature (): System.IFormatProvider use System.IO.TextWriter"
		alias
			"get_FormatProvider"
		end

feature -- Element Change

	set_new_line (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"set_NewLine"
		end

feature -- Basic Operations

	write_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_int64 (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	frozen synchronized (writer: TEXT_WRITER): TEXT_WRITER is
		external
			"IL static signature (System.IO.TextWriter): System.IO.TextWriter use System.IO.TextWriter"
		alias
			"Synchronized"
		end

	write_line is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_string_array_object (format: SYSTEM_STRING; arg: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_string_object_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_object (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"Close"
		end

	write_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_object (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_string_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_string_object_object_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT; arg1: SYSTEM_OBJECT; arg2: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_string_object (format: SYSTEM_STRING; arg0: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_decimal (value: DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_decimal (value: DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	flush is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"Flush"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.TextWriter"
		alias
			"Dispose"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"System.IDisposable.Dispose"
		end

end -- class TEXT_WRITER
