indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.StringWriter"

external class
	SYSTEM_IO_STRINGWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		redefine
			write_string,
			write_array_char_int32,
			write_char,
			dispose,
			close,
			to_string
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_stringwriter_1,
	make_stringwriter_3,
	make_stringwriter_2,
	make_stringwriter

feature {NONE} -- Initialization

	frozen make_stringwriter_1 (format_provider: SYSTEM_IFORMATPROVIDER) is
		external
			"IL creator signature (System.IFormatProvider) use System.IO.StringWriter"
		end

	frozen make_stringwriter_3 (sb: SYSTEM_TEXT_STRINGBUILDER; format_provider: SYSTEM_IFORMATPROVIDER) is
		external
			"IL creator signature (System.Text.StringBuilder, System.IFormatProvider) use System.IO.StringWriter"
		end

	frozen make_stringwriter_2 (sb: SYSTEM_TEXT_STRINGBUILDER) is
		external
			"IL creator signature (System.Text.StringBuilder) use System.IO.StringWriter"
		end

	frozen make_stringwriter is
		external
			"IL creator use System.IO.StringWriter"
		end

feature -- Access

	get_encoding: SYSTEM_TEXT_ENCODING is
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

	get_string_builder: SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (): System.Text.StringBuilder use System.IO.StringWriter"
		alias
			"GetStringBuilder"
		end

	write_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.StringWriter"
		alias
			"ToString"
		end

	write_string (value: STRING) is
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

end -- class SYSTEM_IO_STRINGWRITER
