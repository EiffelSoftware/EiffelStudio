indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.UnicodeEncoding"

external class
	SYSTEM_TEXT_UNICODEENCODING

inherit
	SYSTEM_TEXT_ENCODING
		redefine
			get_decoder,
			get_bytes_string_int32_int32_array_byte_int32,
			get_bytes,
			get_byte_count_string,
			get_preamble,
			get_hash_code,
			is_equal
		end

create
	make_unicodeencoding,
	make_unicodeencoding_1

feature {NONE} -- Initialization

	frozen make_unicodeencoding is
		external
			"IL creator use System.Text.UnicodeEncoding"
		end

	frozen make_unicodeencoding_1 (big_endian: BOOLEAN; byte_order_mark: BOOLEAN) is
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

	get_preamble: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Text.UnicodeEncoding"
		alias
			"GetPreamble"
		end

	get_char_count_array_byte_int32 (bytes: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetCharCount"
		end

	get_decoder: SYSTEM_TEXT_DECODER is
		external
			"IL signature (): System.Text.Decoder use System.Text.UnicodeEncoding"
		alias
			"GetDecoder"
		end

	get_bytes (s: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String): System.Byte[] use System.Text.UnicodeEncoding"
		alias
			"GetBytes"
		end

	get_byte_count_array_char_int32 (chars: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetByteCount"
		end

	get_chars_array_byte_int32_int32_array_char (bytes: ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
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

	get_bytes_array_char_int32_int32_array_byte_int32 (chars: ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetBytes"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.UnicodeEncoding"
		alias
			"Equals"
		end

	get_byte_count_string (s: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.UnicodeEncoding"
		alias
			"GetByteCount"
		end

	get_bytes_string_int32_int32_array_byte_int32 (chars: STRING; char_index: INTEGER; char_count: INTEGER; bytes: ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
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

end -- class SYSTEM_TEXT_UNICODEENCODING
