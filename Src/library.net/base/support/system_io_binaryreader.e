indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.BinaryReader"

external class
	SYSTEM_IO_BINARYREADER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (input: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.BinaryReader"
		end

	frozen make_1 (input: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.BinaryReader"
		end

feature -- Access

	get_base_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.BinaryReader"
		alias
			"get_BaseStream"
		end

feature -- Basic Operations

	read_bytes (count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Int32): System.Byte[] use System.IO.BinaryReader"
		alias
			"ReadBytes"
		end

	peek_char: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryReader"
		alias
			"PeekChar"
		end

	read_int64: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.IO.BinaryReader"
		alias
			"ReadInt64"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.IO.BinaryReader"
		alias
			"Equals"
		end

	read_decimal: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.IO.BinaryReader"
		alias
			"ReadDecimal"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.BinaryReader"
		alias
			"Close"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryReader"
		alias
			"GetHashCode"
		end

	read_byte: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.IO.BinaryReader"
		alias
			"ReadByte"
		end

	read: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryReader"
		alias
			"Read"
		end

	read_array_char (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.BinaryReader"
		alias
			"Read"
		end

	read_array_byte (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.IO.BinaryReader"
		alias
			"Read"
		end

	read_single: REAL is
		external
			"IL signature (): System.Single use System.IO.BinaryReader"
		alias
			"ReadSingle"
		end

	read_int16: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.IO.BinaryReader"
		alias
			"ReadInt16"
		end

	read_chars (count: INTEGER): ARRAY [CHARACTER] is
		external
			"IL signature (System.Int32): System.Char[] use System.IO.BinaryReader"
		alias
			"ReadChars"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.BinaryReader"
		alias
			"ToString"
		end

	read_boolean: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.IO.BinaryReader"
		alias
			"ReadBoolean"
		end

	read_double: DOUBLE is
		external
			"IL signature (): System.Double use System.IO.BinaryReader"
		alias
			"ReadDouble"
		end

	read_char: CHARACTER is
		external
			"IL signature (): System.Char use System.IO.BinaryReader"
		alias
			"ReadChar"
		end

	read_int32: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryReader"
		alias
			"ReadInt32"
		end

	read_string: STRING is
		external
			"IL signature (): System.String use System.IO.BinaryReader"
		alias
			"ReadString"
		end

feature {NONE} -- Implementation

	frozen read7_bit_encoded_int: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryReader"
		alias
			"Read7BitEncodedInt"
		end

	fill_buffer (num_bytes: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.BinaryReader"
		alias
			"FillBuffer"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.BinaryReader"
		alias
			"Dispose"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.IO.BinaryReader"
		alias
			"System.IDisposable.Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.IO.BinaryReader"
		alias
			"Finalize"
		end

end -- class SYSTEM_IO_BINARYREADER
