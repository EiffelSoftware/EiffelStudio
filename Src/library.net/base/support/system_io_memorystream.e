indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.MemoryStream"

external class
	SYSTEM_IO_MEMORYSTREAM

inherit
	SYSTEM_IO_STREAM
		redefine
			write_byte,
			read_byte,
			dispose,
			close
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_memorystream_6,
	make_memorystream_1,
	make_memorystream_3,
	make_memorystream_2,
	make_memorystream,
	make_memorystream_5,
	make_memorystream_4

feature {NONE} -- Initialization

	frozen make_memorystream_6 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER; writable: BOOLEAN; publicly_visible: BOOLEAN) is
		external
			"IL creator signature (System.Byte[], System.Int32, System.Int32, System.Boolean, System.Boolean) use System.IO.MemoryStream"
		end

	frozen make_memorystream_1 (capacity: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.IO.MemoryStream"
		end

	frozen make_memorystream_3 (buffer: ARRAY [INTEGER_8]; writable: BOOLEAN) is
		external
			"IL creator signature (System.Byte[], System.Boolean) use System.IO.MemoryStream"
		end

	frozen make_memorystream_2 (buffer: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.IO.MemoryStream"
		end

	frozen make_memorystream is
		external
			"IL creator use System.IO.MemoryStream"
		end

	frozen make_memorystream_5 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER; writable: BOOLEAN) is
		external
			"IL creator signature (System.Byte[], System.Int32, System.Int32, System.Boolean) use System.IO.MemoryStream"
		end

	frozen make_memorystream_4 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL creator signature (System.Byte[], System.Int32, System.Int32) use System.IO.MemoryStream"
		end

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.MemoryStream"
		alias
			"get_CanWrite"
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

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.MemoryStream"
		alias
			"get_Length"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.MemoryStream"
		alias
			"get_CanSeek"
		end

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.MemoryStream"
		alias
			"get_Position"
		end

feature -- Element Change

	set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.MemoryStream"
		alias
			"set_Capacity"
		end

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.MemoryStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	read (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.MemoryStream"
		alias
			"Read"
		end

	read_byte: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.MemoryStream"
		alias
			"ReadByte"
		end

	write_to (stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.IO.MemoryStream"
		alias
			"WriteTo"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.MemoryStream"
		alias
			"Close"
		end

	get_buffer: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.IO.MemoryStream"
		alias
			"GetBuffer"
		end

	to_array: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.IO.MemoryStream"
		alias
			"ToArray"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.MemoryStream"
		alias
			"SetLength"
		end

	flush is
		external
			"IL signature (): System.Void use System.IO.MemoryStream"
		alias
			"Flush"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.MemoryStream"
		alias
			"WriteByte"
		end

	write (buffer: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.MemoryStream"
		alias
			"Write"
		end

	seek (offset: INTEGER_64; loc: SYSTEM_IO_SEEKORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int64, System.IO.SeekOrigin): System.Int64 use System.IO.MemoryStream"
		alias
			"Seek"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.MemoryStream"
		alias
			"Dispose"
		end

end -- class SYSTEM_IO_MEMORYSTREAM
