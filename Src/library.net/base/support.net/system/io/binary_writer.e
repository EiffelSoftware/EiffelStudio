indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.BinaryWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	BINARY_WRITER

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

	frozen make (output: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.BinaryWriter"
		end

	frozen make_1 (output: SYSTEM_STREAM; encoding: ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.BinaryWriter"
		end

feature -- Access

	frozen null: BINARY_WRITER is
		external
			"IL static_field signature :System.IO.BinaryWriter use System.IO.BinaryWriter"
		alias
			"Null"
		end

	get_base_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.BinaryWriter"
		alias
			"get_BaseStream"
		end

feature -- Basic Operations

	write_array_char (chars: NATIVE_ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_byte (buffer: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_int32 (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.IO.BinaryWriter"
		alias
			"Equals"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"Close"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryWriter"
		alias
			"GetHashCode"
		end

	write (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_byte (value: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_single (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_int16 (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	flush is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"Flush"
		end

	write_char (ch: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_byte_int32_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	seek (offset: INTEGER; origin: SEEK_ORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int32, System.IO.SeekOrigin): System.Int64 use System.IO.BinaryWriter"
		alias
			"Seek"
		end

	write_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_int64 (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_decimal (value: DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.BinaryWriter"
		alias
			"ToString"
		end

	write_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_char_int32_int32 (chars: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

feature {NONE} -- Implementation

	frozen write7_bit_encoded_int (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write7BitEncodedInt"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.BinaryWriter"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"System.IDisposable.Dispose"
		end

end -- class BINARY_WRITER
