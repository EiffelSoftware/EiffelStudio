indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.StreamWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STREAM_WRITER

inherit
	TEXT_WRITER
		rename
			null as null579
		redefine
			write_string,
			write_array_char_int32,
			write_array_char,
			write_char,
			flush,
			dispose,
			close,
			finalize
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_stream_writer_4,
	make_stream_writer,
	make_stream_writer_6,
	make_stream_writer_1,
	make_stream_writer_2,
	make_stream_writer_3,
	make_stream_writer_5

feature {NONE} -- Initialization

	frozen make_stream_writer_4 (path: SYSTEM_STRING; append: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.IO.StreamWriter"
		end

	frozen make_stream_writer (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_6 (path: SYSTEM_STRING; append: BOOLEAN; encoding: ENCODING; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.Boolean, System.Text.Encoding, System.Int32) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_1 (stream: SYSTEM_STREAM; encoding: ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_2 (stream: SYSTEM_STREAM; encoding: ENCODING; buffer_size: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Int32) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_3 (path: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.StreamWriter"
		end

	frozen make_stream_writer_5 (path: SYSTEM_STRING; append: BOOLEAN; encoding: ENCODING) is
		external
			"IL creator signature (System.String, System.Boolean, System.Text.Encoding) use System.IO.StreamWriter"
		end

feature -- Access

	get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.IO.StreamWriter"
		alias
			"get_Encoding"
		end

	frozen null: STREAM_WRITER is
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

	get_base_stream: SYSTEM_STREAM is
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

	write_array_char_int32 (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.StreamWriter"
		alias
			"Write"
		end

	write_array_char (buffer: NATIVE_ARRAY [CHARACTER]) is
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

	write_string (value: SYSTEM_STRING) is
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

	finalize is
		external
			"IL signature (): System.Void use System.IO.StreamWriter"
		alias
			"Finalize"
		end

end -- class STREAM_WRITER
