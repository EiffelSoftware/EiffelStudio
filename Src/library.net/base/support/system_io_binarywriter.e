indexing
	Generator: "Eiffel Emitter 2.5b2"
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
			dispose as disposable_Dispose
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.IO.BinaryWriter"
		alias
			"Equals"
		end

	write_integer (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_byte (buffer: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write (ch: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_decimal (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_boolean (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_char (chars: ARRAY [CHARACTER]) is
		external
			"IL signature (System.Char[]): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_array_char_at (chars: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_int16 (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_double (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	write_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	wipe_out is
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

	write_int64 (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"Close"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.BinaryWriter"
		alias
			"ToString"
		end

	seek (offset: INTEGER; origin: INTEGER): INTEGER_64 is
			-- Valid values for `origin' are:
			-- Begin = 0
			-- Current = 1
			-- End = 2
		require
			valid_seek_origin: origin = 0 or origin = 1 or origin = 2
		external
			"IL signature (System.Int32, enum System.IO.SeekOrigin): System.Int64 use System.IO.BinaryWriter"
		alias
			"Seek"
		end

	write_array_byte_at (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"Finalize"
		end

	frozen write_7Bit_incoded_int (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.IO.BinaryWriter"
		alias
			"Write7BitEncodedInt"
		end

	frozen disposable_dispose is
		external
			"IL signature (): System.Void use System.IO.BinaryWriter"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_IO_BINARYWRITER
