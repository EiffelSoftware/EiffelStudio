indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.StreamWriter"

external class
	SYSTEM_IO_STREAMWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		rename
			null as null267
		redefine
			write_string,
			write_array_char_int32,
			write_array_char,
			write_char,
			flush,
			dispose,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_streamwriter,
	make_streamwriter_4,
	make_streamwriter_5,
	make_streamwriter_3,
	make_streamwriter_2,
	make_streamwriter_1,
	make_streamwriter_6

feature {NONE} -- Initialization

	frozen make_streamwriter (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.StreamWriter"
		end

	frozen make_streamwriter_4 (path: STRING; append: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.IO.StreamWriter"
		end

	frozen make_streamwriter_5 (path: STRING; append: BOOLEAN; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.String, System.Boolean, System.Text.Encoding) use System.IO.StreamWriter"
		end

	frozen make_streamwriter_3 (path: STRING) is
		external
			"IL creator signature (System.String) use System.IO.StreamWriter"
		end

	frozen make_streamwriter_2 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING; buffer_size: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Int32) use System.IO.StreamWriter"
		end

	frozen make_streamwriter_1 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.StreamWriter"
		end

	frozen make_streamwriter_6 (path: STRING; append: BOOLEAN; encoding: SYSTEM_TEXT_ENCODING; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.Boolean, System.Text.Encoding, System.Int32) use System.IO.StreamWriter"
		end

feature -- Access

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.IO.StreamWriter"
		alias
			"get_Encoding"
		end

	frozen null: SYSTEM_IO_STREAMWRITER is
		external
			"IL static_field signature :System.IO.StreamWriter use System.IO.StreamWriter"
		alias
			"Null"
		end

	get_auto_flush: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.StreamWriter"
		alias
			"get_AutoFlush"
		end

	get_base_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.StreamWriter"
		alias
			"get_BaseStream"
		end

feature -- Element Change

	set_auto_flush (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.StreamWriter"
		alias
			"set_AutoFlush"
		end

feature -- Basic Operations

	write_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	write_array_char_int32 (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	write_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	flush is
		external
			"IL signature (): System.Void use System.IO.StreamWriter"
		alias
			"Flush"
		end

	write_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.StreamWriter"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.StreamWriter"
		alias
			"Dispose"
		end

end -- class SYSTEM_IO_STREAMWRITER
