indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.StreamReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	STREAM_READER

inherit
	TEXT_READER
		rename
			null as null577
		redefine
			read_line,
			read_to_end,
			read_array_char,
			read,
			peek,
			dispose,
			close
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_stream_reader_8,
	make_stream_reader,
	make_stream_reader_6,
	make_stream_reader_7,
	make_stream_reader_4,
	make_stream_reader_5,
	make_stream_reader_2,
	make_stream_reader_3,
	make_stream_reader_1,
	make_stream_reader_9

feature {NONE} -- Initialization

	frozen make_stream_reader_8 (path: SYSTEM_STRING; encoding: ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Text.Encoding, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.StreamReader"
		end

	frozen make_stream_reader_6 (path: SYSTEM_STRING; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_7 (path: SYSTEM_STRING; encoding: ENCODING) is
		external
			"IL creator signature (System.String, System.Text.Encoding) use System.IO.StreamReader"
		end

	frozen make_stream_reader_4 (stream: SYSTEM_STREAM; encoding: ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN; buffer_size: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Boolean, System.Int32) use System.IO.StreamReader"
		end

	frozen make_stream_reader_5 (path: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.StreamReader"
		end

	frozen make_stream_reader_2 (stream: SYSTEM_STREAM; encoding: ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.StreamReader"
		end

	frozen make_stream_reader_3 (stream: SYSTEM_STREAM; encoding: ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_1 (stream: SYSTEM_STREAM; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_stream_reader_9 (path: SYSTEM_STRING; encoding: ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.Text.Encoding, System.Boolean, System.Int32) use System.IO.StreamReader"
		end

feature -- Access

	frozen null: STREAM_READER is
		external
			"IL static_field signature :System.IO.StreamReader use System.IO.StreamReader"
		alias
			"Null"
		end

	get_current_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.IO.StreamReader"
		alias
			"get_CurrentEncoding"
		end

	get_base_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.StreamReader"
		alias
			"get_BaseStream"
		end

feature -- Basic Operations

	read_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
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

	read_to_end: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.StreamReader"
		alias
			"ReadToEnd"
		end

	frozen discard_buffered_data is
		external
			"IL signature (): System.Void use System.IO.StreamReader"
		alias
			"DiscardBufferedData"
		end

	read: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.StreamReader"
		alias
			"Read"
		end

	read_line: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.StreamReader"
		alias
			"ReadLine"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.StreamReader"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.StreamReader"
		alias
			"Dispose"
		end

end -- class STREAM_READER
