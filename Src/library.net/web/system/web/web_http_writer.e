indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpWriter"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_WRITER

inherit
	TEXT_WRITER
		redefine
			write_line,
			write_object,
			write_string,
			write_array_char_int32,
			write_char,
			flush,
			close
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create {NONE}

feature -- Access

	get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.HttpWriter"
		alias
			"get_Encoding"
		end

	frozen get_output_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpWriter"
		alias
			"get_OutputStream"
		end

feature -- Basic Operations

	write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
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

	frozen write_bytes (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
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

	write_string (s: SYSTEM_STRING) is
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

	frozen write_string_string_int32 (s: SYSTEM_STRING; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Void use System.Web.HttpWriter"
		alias
			"WriteString"
		end

	write_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.HttpWriter"
		alias
			"Write"
		end

end -- class WEB_HTTP_WRITER
