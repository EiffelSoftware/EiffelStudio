indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.BinaryWriter"

external class
	SYSTEM_IO_BINARYWRITER

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

	frozen make (output: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.IO.BinaryWriter"
		end

	frozen make_1 (output: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.IO.BinaryWriter"
		end

feature -- Access

	frozen null: SYSTEM_IO_BINARYWRITER is
		external
			"IL static_field signature :System.IO.BinaryWriter use System.IO.BinaryWriter"
		alias
			"Null"
		end

	get_base_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.IO.BinaryWriter"
		alias
			"get_BaseStream"
		end

feature -- Basic Operations

	write_array_char (chars: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_byte (buffer: ARRAY [INTEGER_8]) is
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

	is_equal (obj: ANY): BOOLEAN is
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

	write (ch: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_double (value: DOUBLE) is
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

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.IO.BinaryWriter"
		alias
			"GetHashCode"
		end

	write_array_byte_int32_int32 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	seek (offset: INTEGER; origin: SYSTEM_IO_SEEKORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int32, System.IO.SeekOrigin): System.Int64 use System.IO.BinaryWriter"
		alias
			"Seek"
		end

	write_string (value: STRING) is
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

	write_decimal (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	to_string: STRING is
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

	write_array_char_int32_int32 (chars: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
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

end -- class SYSTEM_IO_BINARYWRITER
