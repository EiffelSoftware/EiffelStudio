indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.StringWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STRING_WRITER

inherit
	TEXT_WRITER
		redefine
			write_string,
			write_array_char_int32,
			write_char,
			dispose,
			close,
			to_string
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_string_writer_3,
	make_string_writer_2,
	make_string_writer,
	make_string_writer_1

feature {NONE} -- Initialization

	frozen make_string_writer_3 (sb: STRING_BUILDER; format_provider: IFORMAT_PROVIDER) is
		external
			"IL creator signature (System.Text.StringBuilder, System.IFormatProvider) use System.IO.StringWriter"
		end

	frozen make_string_writer_2 (sb: STRING_BUILDER) is
		external
			"IL creator signature (System.Text.StringBuilder) use System.IO.StringWriter"
		end

	frozen make_string_writer is
		external
			"IL creator use System.IO.StringWriter"
		end

	frozen make_string_writer_1 (format_provider: IFORMAT_PROVIDER) is
		external
			"IL creator signature (System.IFormatProvider) use System.IO.StringWriter"
		end

feature -- Access

	get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.IO.StringWriter"
		alias
			"get_Encoding"
		end

feature -- Basic Operations

	write_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

	get_string_builder: STRING_BUILDER is
		external
			"IL signature (): System.Text.StringBuilder use System.IO.StringWriter"
		alias
			"GetStringBuilder"
		end

	write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.StringWriter"
		alias
			"ToString"
		end

	write_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.StringWriter"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.StringWriter"
		alias
			"Dispose"
		end

end -- class STRING_WRITER
