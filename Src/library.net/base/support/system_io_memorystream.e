indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.MemoryStream"

external class
	SYSTEM_IO_MEMORYSTREAM

inherit
	SYSTEM_IO_STREAM
		redefine
			write_byte,
			write,
			read_byte,
			read
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as disposable_Dispose
		end

create
	make_memory_stream_6,
	make_memory_stream_1,
	make_memory_stream_3,
	make_memory_stream_2,
	make_memory_stream,
	make_memory_stream_5,
	make_memory_stream_4

feature {NONE} -- Initialization

	frozen make_memory_stream_6 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER; writable: BOOLEAN; publiclyVisible: BOOLEAN) is
		external
			"IL creator signature (System.Byte[], System.Int32, System.Int32, System.Boolean, System.Boolean) use System.IO.MemoryStream"
		end

	frozen make_memory_stream_1 (capacity2: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.IO.MemoryStream"
		end

	frozen make_memory_stream_3 (buffer: ARRAY [INTEGER_8]; writable: BOOLEAN) is
		external
			"IL creator signature (System.Byte[], System.Boolean) use System.IO.MemoryStream"
		end

	frozen make_memory_stream_2 (buffer: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.IO.MemoryStream"
		end

	frozen make_memory_stream is
		external
			"IL creator use System.IO.MemoryStream"
		end

	frozen make_memory_stream_5 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER; writable: BOOLEAN) is
		external
			"IL creator signature (System.Byte[], System.Int32, System.Int32, System.Boolean) use System.IO.MemoryStream"
		end

	frozen make_memory_stream_4 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL creator signature (System.Byte[], System.Int32, System.Int32) use System.IO.MemoryStream"
		end

feature -- Access

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.MemoryStream"
		alias
			"get_Position"
		end

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.MemoryStream"
		alias
			"get_CanWrite"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.MemoryStream"
		alias
			"get_CanSeek"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.MemoryStream"
		alias
			"get_Length"
		end

	get_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.MemoryStream"
		alias
			"get_Capacity"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.MemoryStream"
		alias
			"get_CanRead"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.MemoryStream"
		alias
			"set_Position"
		end

	set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.MemoryStream"
		alias
			"set_Capacity"
		end

feature -- Basic Operations

	get_buffer: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.IO.MemoryStream"
		alias
			"GetBuffer"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.MemoryStream"
		alias
			"ReadByte"
		end

	read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.MemoryStream"
		alias
			"Read"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.MemoryStream"
		alias
			"SetLength"
		end

	to_array: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.IO.MemoryStream"
		alias
			"ToArray"
		end

	write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.MemoryStream"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.MemoryStream"
		alias
			"Close"
		end

	write_to (stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.IO.MemoryStream"
		alias
			"WriteTo"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.MemoryStream"
		alias
			"WriteByte"
		end

	wipe_out is
		external
			"IL signature (): System.Void use System.IO.MemoryStream"
		alias
			"Flush"
		end

	seek (offset: INTEGER_64; loc: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int64, enum System.IO.SeekOrigin): System.Int64 use System.IO.MemoryStream"
		alias
			"Seek"
		end

end -- class SYSTEM_IO_MEMORYSTREAM
