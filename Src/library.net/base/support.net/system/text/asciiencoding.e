indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.ASCIIEncoding"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ASCIIENCODING

inherit
	ENCODING
		redefine
			get_string_array_byte_int32,
			get_string,
			get_bytes_string_int32_int32_array_byte_int32,
			get_byte_count
		end

create
	make_asciiencoding

feature {NONE} -- Initialization

	frozen make_asciiencoding is
		external
			"IL creator use System.Text.ASCIIEncoding"
		end

feature -- Basic Operations

	get_max_char_count (byte_count: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetMaxCharCount"
		end

	get_char_count_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetCharCount"
		end

	get_bytes_string_int32_int32_array_byte_int32 (chars: SYSTEM_STRING; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetBytes"
		end

	get_byte_count (chars: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetByteCount"
		end

	get_byte_count_array_char_int32 (chars: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetByteCount"
		end

	get_chars_array_byte_int32_int32_array_char (bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetChars"
		end

	get_max_byte_count (char_count: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetMaxByteCount"
		end

	get_bytes_array_char_int32_int32_array_byte_int32 (chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.ASCIIEncoding"
		alias
			"GetBytes"
		end

	get_string_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.String use System.Text.ASCIIEncoding"
		alias
			"GetString"
		end

	get_string (bytes: NATIVE_ARRAY [INTEGER_8]): SYSTEM_STRING is
		external
			"IL signature (System.Byte[]): System.String use System.Text.ASCIIEncoding"
		alias
			"GetString"
		end

end -- class ASCIIENCODING
