indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.UnicodeEncoding"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	UNICODE_ENCODING

inherit
	ENCODING
		redefine
			get_decoder,
			get_bytes_string_int32_int32_array_byte_int32,
			get_bytes,
			get_byte_count,
			get_preamble,
			get_hash_code,
			equals
		end

create
	make_unicode_encoding,
	make_unicode_encoding_1

feature {NONE} -- Initialization

	frozen make_unicode_encoding is
		external
			"IL creator use System.Text.UnicodeEncoding"
		end

	frozen make_unicode_encoding_1 (big_endian: BOOLEAN; byte_order_mark: BOOLEAN) is
		external
			"IL creator signature (System.Boolean, System.Boolean) use System.Text.UnicodeEncoding"
		end

feature -- Access

	frozen char_size: INTEGER is 0x2

feature -- Basic Operations

	get_max_char_count (byte_count: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetMaxCharCount"
		end

	get_preamble: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Text.UnicodeEncoding"
		alias
			"GetPreamble"
		end

	get_char_count_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetCharCount"
		end

	get_decoder: DECODER is
		external
			"IL signature (): System.Text.Decoder use System.Text.UnicodeEncoding"
		alias
			"GetDecoder"
		end

	get_bytes (s: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String): System.Byte[] use System.Text.UnicodeEncoding"
		alias
			"GetBytes"
		end

	get_byte_count_array_char_int32 (chars: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetByteCount"
		end

	get_chars_array_byte_int32_int32_array_char (bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetChars"
		end

	get_max_byte_count (char_count: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetMaxByteCount"
		end

	get_bytes_array_char_int32_int32_array_byte_int32 (chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetBytes"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.UnicodeEncoding"
		alias
			"Equals"
		end

	get_byte_count (s: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetByteCount"
		end

	get_bytes_string_int32_int32_array_byte_int32 (s: SYSTEM_STRING; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetBytes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetHashCode"
		end

end -- class UNICODE_ENCODING
