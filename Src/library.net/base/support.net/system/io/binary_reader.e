indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.BinaryReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	BINARY_READER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (input: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.BinaryReader"
		end

	frozen make_1 (input: SYSTEM_STREAM; encoding: ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.BinaryReader"
		end

feature -- Access

	get_base_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.BinaryReader"
		alias
			"get_BaseStream"
		end

feature -- Basic Operations

	read_bytes (count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.IO.BinaryReader"
		alias
			"Equals"
		end

	read_decimal: DECIMAL is
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

	read_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.IO.BinaryReader"
		alias
			"Read"
		end

	read_array_byte (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
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

	read_chars (count: INTEGER): NATIVE_ARRAY [CHARACTER] is
		external
			"IL signature (System.Int32): System.Char[] use System.IO.BinaryReader"
		alias
			"ReadChars"
		end

	to_string: SYSTEM_STRING is
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

	read_string: SYSTEM_STRING is
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

end -- class BINARY_READER
