indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.StreamReader"

external class
	SYSTEM_IO_STREAMREADER

inherit
	SYSTEM_IO_TEXTREADER
		rename
			null as null386
		redefine
			read_line,
			read_to_end,
			read_array_char,
			read,
			peek,
			dispose,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_streamreader_4,
	make_streamreader,
	make_streamreader_6,
	make_streamreader_9,
	make_streamreader_8,
	make_streamreader_1,
	make_streamreader_7,
	make_streamreader_3,
	make_streamreader_2,
	make_streamreader_5

feature {NONE} -- Initialization

	frozen make_streamreader_4 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN; buffer_size: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Boolean, System.Int32) use System.IO.StreamReader"
		end

	frozen make_streamreader (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.StreamReader"
		end

	frozen make_streamreader_6 (path: STRING; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_streamreader_9 (path: STRING; encoding: SYSTEM_TEXT_ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN; buffer_size: INTEGER) is
		external
			"IL creator signature (System.String, System.Text.Encoding, System.Boolean, System.Int32) use System.IO.StreamReader"
		end

	frozen make_streamreader_8 (path: STRING; encoding: SYSTEM_TEXT_ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Text.Encoding, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_streamreader_1 (stream: SYSTEM_IO_STREAM; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_streamreader_7 (path: STRING; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.String, System.Text.Encoding) use System.IO.StreamReader"
		end

	frozen make_streamreader_3 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING; detect_encoding_from_byte_order_marks: BOOLEAN) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding, System.Boolean) use System.IO.StreamReader"
		end

	frozen make_streamreader_2 (stream: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.StreamReader"
		end

	frozen make_streamreader_5 (path: STRING) is
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

	read_array_char (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
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

	read_to_end: STRING is
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

	read_line: STRING is
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

end -- class SYSTEM_IO_STREAMREADER
