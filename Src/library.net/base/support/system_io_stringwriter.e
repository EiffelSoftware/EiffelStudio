indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.StringWriter"

external class
	SYSTEM_IO_STRINGWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		redefine
			put_string,
			put_array_char_at,
			put_char,
			close,
			to_string
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_Dispose
		end

create
	make_string_writer_1,
	make_string_writer_3,
	make_string_writer_2,
	make_string_writer

feature {NONE} -- Initialization

	frozen make_string_writer_1 (formatProvider2: SYSTEM_IFORMATPROVIDER) is
		external
			"IL creator signature (System.IFormatProvider) use System.IO.StringWriter"
		end

	frozen make_string_writer_3 (sb: SYSTEM_TEXT_STRINGBUILDER; formatProvider2: SYSTEM_IFORMATPROVIDER) is
		external
			"IL creator signature (System.Text.StringBuilder, System.IFormatProvider) use System.IO.StringWriter"
		end

	frozen make_string_writer_2 (sb: SYSTEM_TEXT_STRINGBUILDER) is
		external
			"IL creator signature (System.Text.StringBuilder) use System.IO.StringWriter"
		end

	frozen make_string_writer is
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

	put_array_char_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.StringWriter"
		alias
			"Close"
		end

	put_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

	get_string_builder: SYSTEM_TEXT_STRINGBUILDER is
		external
			"IL signature (): System.Text.StringBuilder use System.IO.StringWriter"
		alias
			"GetStringBuilder"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.StringWriter"
		alias
			"ToString"
		end

	put_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.StringWriter"
		alias
			"Write"
		end

end -- class SYSTEM_IO_STRINGWRITER
