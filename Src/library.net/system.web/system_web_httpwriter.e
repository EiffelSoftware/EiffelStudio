indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpWriter"

frozen external class
	SYSTEM_WEB_HTTPWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		redefine
			write_line,
			write_object,
			write_string,
			write_array_char_int32,
			write_char,
			flush,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create {NONE}

feature -- Access

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.HttpWriter"
		alias
			"get_Encoding"
		end

	frozen get_output_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpWriter"
		alias
			"get_OutputStream"
		end

feature -- Basic Operations

	write_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Web.HttpWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.Web.HttpWriter"
		alias
			"Close"
		end

	frozen write_bytes (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Web.HttpWriter"
		alias
			"WriteBytes"
		end

	write_char (ch: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Web.HttpWriter"
		alias
			"Write"
		end

	write_string (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpWriter"
		alias
			"Write"
		end

	flush is
		external
			"IL signature (): System.Void use System.Web.HttpWriter"
		alias
			"Flush"
		end

	write_line is
		external
			"IL signature (): System.Void use System.Web.HttpWriter"
		alias
			"WriteLine"
		end

	frozen write_string_string_int32 (s: STRING; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Void use System.Web.HttpWriter"
		alias
			"WriteString"
		end

	write_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.HttpWriter"
		alias
			"Write"
		end

end -- class SYSTEM_WEB_HTTPWRITER
