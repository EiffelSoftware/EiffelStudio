indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.BufferedStream"

frozen external class
	SYSTEM_IO_BUFFEREDSTREAM

inherit
	SYSTEM_IO_STREAM
		redefine
			write_byte,
			Write,
			read_byte,
			read
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_dispose
		end

create
	make_buffered_stream_1,
	make_buffered_stream

feature {NONE} -- Initialization

	frozen make_buffered_stream_1 (stream: SYSTEM_IO_STREAM; bufferSize: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Int32) use System.IO.BufferedStream"
		end

	frozen make_buffered_stream (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.BufferedStream"
		end

feature -- Access

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.BufferedStream"
		alias
			"get_Position"
		end

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.BufferedStream"
		alias
			"get_CanWrite"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.BufferedStream"
		alias
			"get_CanSeek"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.BufferedStream"
		alias
			"get_Length"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.BufferedStream"
		alias
			"get_CanRead"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.BufferedStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.BufferedStream"
		alias
			"WriteByte"
		end

	read (array: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.BufferedStream"
		alias
			"Read"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BufferedStream"
		alias
			"ReadByte"
		end

	write (array: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.BufferedStream"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.BufferedStream"
		alias
			"Close"
		end

	seek (offset: INTEGER_64; origin: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int64, enum System.IO.SeekOrigin): System.Int64 use System.IO.BufferedStream"
		alias
			"Seek"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.BufferedStream"
		alias
			"SetLength"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.IO.BufferedStream"
		alias
			"Flush"
		end

end -- class SYSTEM_IO_BUFFEREDSTREAM
