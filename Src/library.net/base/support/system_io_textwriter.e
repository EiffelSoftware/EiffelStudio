indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.TextWriter"

deferred external class
	SYSTEM_IO_TEXTWRITER

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

feature -- Access

	get_format_provider: SYSTEM_IFORMATPROVIDER is
		external
			"IL signature (): System.IFormatProvider use System.IO.TextWriter"
		alias
			"get_FormatProvider"
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

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL deferred signature (): System.Text.Encoding use System.IO.TextWriter"
		alias
			"get_Encoding"
		end

feature -- Element Change

	set_new_line (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"set_NewLine"
		end

feature -- Basic Operations

	put_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_real (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_int64_and_line (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_int64 (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_line_and_characters_from (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_any (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"Flush"
		end

	put_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_line_and_one_format_string (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	frozen synchronized (writer: SYSTEM_IO_TEXTWRITER): SYSTEM_IO_TEXTWRITER is
		external
			"IL static signature (System.IO.TextWriter): System.IO.TextWriter use System.IO.TextWriter"
		alias
			"Synchronized"
		end

	put_three_format_string (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_one_format_string (format: STRING; arg0: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_array_char_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_decimal (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_real_and_line (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	new_line is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"Close"
		end

	put_multi_format_string (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_two_format_string (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_decimal_abd_line (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_integer_and_line (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_array_char_and_line (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_line_and_multi_format_string (format: STRING; arg: ARRAY [ANY]) is
		external
			"IL signature (System.String, System.Object[]): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_integer (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_char_and_line (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"Write"
		end

	put_string_and_line (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_boolean_and_line (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_double_and_line (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_line_and_two_format_string (format: STRING; arg0: ANY; arg1: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_any_and_line (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

	put_line_and_three_format_string (format: STRING; arg0: ANY; arg1: ANY; arg2: ANY) is
		external
			"IL signature (System.String, System.Object, System.Object, System.Object): System.Void use System.IO.TextWriter"
		alias
			"WriteLine"
		end

feature {NONE} -- Implementation

	frozen disposable_dispose is
		external
			"IL signature (): System.Void use System.IO.TextWriter"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_IO_TEXTWRITER
