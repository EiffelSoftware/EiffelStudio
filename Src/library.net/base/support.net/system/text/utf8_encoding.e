indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.UTF8Encoding"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	UTF8_ENCODING

inherit
	ENCODING
		redefine
			get_encoder,
			get_decoder,
			get_bytes_string_int32_int32_array_byte_int32,
			get_bytes,
			get_byte_count,
			get_preamble,
			get_hash_code,
			equals
		end

create
	make_utf8_encoding,
	make_utf8_encoding_2,
	make_utf8_encoding_1

feature {NONE} -- Initialization

	frozen make_utf8_encoding is
		external
			"IL creator use System.Text.UTF8Encoding"
		end

	frozen make_utf8_encoding_2 (encoder_should_emit_utf8_identifier: BOOLEAN; throw_on_invalid_bytes: BOOLEAN) is
		external
			"IL creator signature (System.Boolean, System.Boolean) use System.Text.UTF8Encoding"
		end

	frozen make_utf8_encoding_1 (encoder_should_emit_utf8_identifier: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Text.UTF8Encoding"
		end

feature -- Basic Operations

	get_max_char_count (byte_count: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetMaxCharCount"
		end

	get_preamble: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Text.UTF8Encoding"
		alias
			"GetPreamble"
		end

	get_char_count_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetCharCount"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetHashCode"
		end

	get_decoder: DECODER is
		external
			"IL signature (): System.Text.Decoder use System.Text.UTF8Encoding"
		alias
			"GetDecoder"
		end

	get_bytes (s: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String): System.Byte[] use System.Text.UTF8Encoding"
		alias
			"GetBytes"
		end

	get_encoder: ENCODER is
		external
			"IL signature (): System.Text.Encoder use System.Text.UTF8Encoding"
		alias
			"GetEncoder"
		end

	get_chars_array_byte_int32_int32_array_char (bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetChars"
		end

	get_max_byte_count (char_count: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetMaxByteCount"
		end

	get_bytes_array_char_int32_int32_array_byte_int32 (chars: NATIVE_ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetBytes"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.UTF8Encoding"
		alias
			"Equals"
		end

	get_byte_count (chars: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetByteCount"
		end

	get_bytes_string_int32_int32_array_byte_int32 (s: SYSTEM_STRING; char_index: INTEGER; char_count: INTEGER; bytes: NATIVE_ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetBytes"
		end

	get_byte_count_array_char_int32 (chars: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Text.UTF8Encoding"
		alias
			"GetByteCount"
		end

end -- class UTF8_ENCODING
