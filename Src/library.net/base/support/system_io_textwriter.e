indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.TextWriter"

deferred external class
	SYSTEM_IO_TEXTWRITER

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

feature -- Access

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL deferred signature (): System.Text.Encoding use System.IO.TextWriter"
		alias
			"get_Encoding"
		end

	frozen null: SYSTEM_IO_TEXTWRITER is
		external
			"IL static_field signature :System.IO.TextWriter use System.IO.TextWriter"
		alias
			"Null"
		end

	get_new_line: STRING is
		external
			"IL signature (): System.String use System.IO.TextWriter"
		alias
			"get_NewLine"
		end

	get_format_provider: SYSTEM_IFORMATPROVIDER is
		external
			"IL signature (): System.IFormatProvider use System.IO.TextWriter"
		alias
			"get_FormatProvider"
		end

feature -- Element Change

	set_new_line (value: STRING) is
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

	frozen synchronized (writer: SYSTEM_IO_TEXTWRITER): SYSTEM_IO_TEXTWRITER is
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

	write_line_string_array_object (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_string_array_object (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_string_object_object (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_string_object_object_object (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY) is
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

	write_line_string (value: STRING) is
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

	write_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_line_object (value: ANY) is
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

	write_line_string_object (format: STRING; arg0: ANY) is
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

	write_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_object (value: ANY) is
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

	write_line_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
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

	write_string_object_object (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_string_object_object_object (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_string_object (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	write_line_decimal (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	write_decimal (value: SYSTEM_DECIMAL) is
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

end -- class SYSTEM_IO_TEXTWRITER
