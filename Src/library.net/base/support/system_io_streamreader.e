indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.StreamReader"

external class
	SYSTEM_IO_STREAMREADER

inherit
	SYSTEM_IO_TEXTREADER
		rename
			Null as Null164
		redefine
			read_line,
			read_to_end,
			read_at,
			read,
			peek,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

create
	make_stream_reader_4,
	make_stream_reader,
	make_stream_reader_6,
	make_stream_reader_9,
	make_stream_reader_8,
	make_stream_reader_1,
	make_stream_reader_7,
	make_stream_reader_3,
	make_stream_reader_2,
	make_stream_reader_5

feature {NONE} -- Initialization

	frozen make_stream_reader_4 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING; detectEncodingFromByteOrderMarks: BOOLEAN; bufferSize: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Boolean, System.Int32) use System.IO.StreamReader"
		end

	frozen make_stream_reader (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.StreamReader"
		end

	frozen make_stream_reader_6 (path: STRING; detectEncodingFromByteOrderMarks: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_9 (path: STRING; encoding: SYSTEM_TEXT_ENCODING; detectEncodingFromByteOrderMarks: BOOLEAN; bufferSize: INTEGER) is
		external
			"IL creator signature (System.String, System.Text.Encoding, System.Boolean, System.Int32) use System.IO.StreamReader"
		end

	frozen make_stream_reader_8 (path: STRING; encoding: SYSTEM_TEXT_ENCODING; detectEncodingFromByteOrderMarks: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Text.Encoding, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_1 (stream: SYSTEM_IO_STREAM; detectEncodingFromByteOrderMarks: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_7 (path: STRING; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.String, System.Text.Encoding) use System.IO.StreamReader"
		end

	frozen make_stream_reader_3 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING; detectEncodingFromByteOrderMarks: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_2 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.StreamReader"
		end

	frozen make_stream_reader_5 (path: STRING) is
		external
			"IL creator signature (System.String) use System.IO.StreamReader"
		end

feature -- Access

	frozen null: SYSTEM_IO_STREAMREADER is
		external
			"IL static_field signature :System.IO.StreamReader use System.IO.StreamReader"
		alias
			"Null"
		end

	get_current_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.IO.StreamReader"
		alias
			"get_CurrentEncoding"
		end

	get_base_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.StreamReader"
		alias
			"get_BaseStream"
		end

feature -- Basic Operations

	close is
		external
			"IL signature (): System.Void use System.IO.StreamReader"
		alias
			"Close"
		end

	read_to_end: STRING is
		external
			"IL signature (): System.String use System.IO.StreamReader"
		alias
			"ReadToEnd"
		end

	read_at (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.StreamReader"
		alias
			"Read"
		end

	peek: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.StreamReader"
		alias
			"Peek"
		end

	read: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.StreamReader"
		alias
			"Read"
		end

	read_line: STRING is
		external
			"IL signature (): System.String use System.IO.StreamReader"
		alias
			"ReadLine"
		end

	frozen discard_buffered_data is
		external
			"IL signature (): System.Void use System.IO.StreamReader"
		alias
			"DiscardBufferedData"
		end

end -- class SYSTEM_IO_STREAMREADER
