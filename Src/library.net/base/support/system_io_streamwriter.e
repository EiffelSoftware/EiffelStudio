indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.StreamWriter"

external class
	SYSTEM_IO_STREAMWRITER

inherit
	SYSTEM_IO_TEXTWRITER
		rename
			null as null228
		redefine
			put_string,
			put_array_char_at,
			put_array_char,
			put_char,
			wipe_out,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_Dispose
		end

create
	make_stream_writer,
	make_stream_writer_4,
	make_stream_writer_5,
	make_stream_writer_3,
	make_stream_writer_2,
	make_stream_writer_1,
	make_stream_writer_6

feature {NONE} -- Initialization

	frozen make_stream_writer (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_4 (path: STRING; append: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_5 (path: STRING; append: BOOLEAN; encoding2: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.String, System.Boolean, System.Text.Encoding) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_3 (path: STRING) is
		external
			"IL creator signature (System.String) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_2 (stream: SYSTEM_IO_STREAM; encoding2: SYSTEM_TEXT_ENCODING; bufferSize: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Int32) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_1 (stream: SYSTEM_IO_STREAM; encoding2: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_6 (path: STRING; append: BOOLEAN; encoding2: SYSTEM_TEXT_ENCODING; bufferSize: INTEGER) is
		external
			"IL creator signature (System.String, System.Boolean, System.Text.Encoding, System.Int32) use System.IO.StreamWriter"
		end

feature -- Access

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

	get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.IO.StreamWriter"
		alias
			"get_Encoding"
		end

feature -- Element Change

	set_auto_flush (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.StreamWriter"
		alias
			"set_AutoFlush"
		end

feature -- Basic Operations

	put_array_char_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.StreamWriter"
		alias
			"Close"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.IO.StreamWriter"
		alias
			"Flush"
		end

	put_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	put_array_char (buffer: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	put_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

end -- class SYSTEM_IO_STREAMWRITER
