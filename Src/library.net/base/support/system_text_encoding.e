indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.Encoding"

deferred external class
	SYSTEM_TEXT_ENCODING

inherit
	ANY
		redefine
			get_hash_code,
			is_equal
		end

feature -- Access

	get_web_name: STRING is
		external
			"IL signature (): System.String use System.Text.Encoding"
		alias
			"get_WebName"
		end

	frozen get_default: SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (): System.Text.Encoding use System.Text.Encoding"
		alias
			"get_Default"
		end

	get_is_mail_news_display: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.Encoding"
		alias
			"get_IsMailNewsDisplay"
		end

	frozen get_utf8: SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (): System.Text.Encoding use System.Text.Encoding"
		alias
			"get_UTF8"
		end

	get_header_name: STRING is
		external
			"IL signature (): System.String use System.Text.Encoding"
		alias
			"get_HeaderName"
		end

	get_encoding_name: STRING is
		external
			"IL signature (): System.String use System.Text.Encoding"
		alias
			"get_EncodingName"
		end

	frozen get_ascii: SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (): System.Text.Encoding use System.Text.Encoding"
		alias
			"get_ASCII"
		end

	get_body_name: STRING is
		external
			"IL signature (): System.String use System.Text.Encoding"
		alias
			"get_BodyName"
		end

	get_is_browser_display: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.Encoding"
		alias
			"get_IsBrowserDisplay"
		end

	frozen get_utf7: SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (): System.Text.Encoding use System.Text.Encoding"
		alias
			"get_UTF7"
		end

	get_is_mail_news_save: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.Encoding"
		alias
			"get_IsMailNewsSave"
		end

	get_code_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.Encoding"
		alias
			"get_CodePage"
		end

	get_windows_code_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.Encoding"
		alias
			"get_WindowsCodePage"
		end

	frozen get_big_endian_unicode: SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (): System.Text.Encoding use System.Text.Encoding"
		alias
			"get_BigEndianUnicode"
		end

	frozen get_unicode: SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (): System.Text.Encoding use System.Text.Encoding"
		alias
			"get_Unicode"
		end

	get_is_browser_save: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.Encoding"
		alias
			"get_IsBrowserSave"
		end

feature -- Basic Operations

	frozen convert (src_encoding: SYSTEM_TEXT_ENCODING; dst_encoding: SYSTEM_TEXT_ENCODING; bytes: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Text.Encoding, System.Text.Encoding, System.Byte[]): System.Byte[] use System.Text.Encoding"
		alias
			"Convert"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.Encoding"
		alias
			"Equals"
		end

	frozen get_encoding (name: STRING): SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (System.String): System.Text.Encoding use System.Text.Encoding"
		alias
			"GetEncoding"
		end

	get_preamble: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Text.Encoding"
		alias
			"GetPreamble"
		end

	get_bytes_array_char_int32_int32 (chars: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Byte[] use System.Text.Encoding"
		alias
			"GetBytes"
		end

	get_max_byte_count (char_count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetMaxByteCount"
		end

	get_max_char_count (byte_count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetMaxCharCount"
		end

	get_char_count (bytes: ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Byte[]): System.Int32 use System.Text.Encoding"
		alias
			"GetCharCount"
		end

	get_string_array_byte_int32 (bytes: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): STRING is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.String use System.Text.Encoding"
		alias
			"GetString"
		end

	get_bytes_string_int32_int32_array_byte_int32 (s: STRING; char_index: INTEGER; char_count: INTEGER; bytes: ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetBytes"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.Encoding"
		alias
			"GetHashCode"
		end

	get_chars (bytes: ARRAY [INTEGER_8]): ARRAY [CHARACTER] is
		external
			"IL signature (System.Byte[]): System.Char[] use System.Text.Encoding"
		alias
			"GetChars"
		end

	get_string (bytes: ARRAY [INTEGER_8]): STRING is
		external
			"IL signature (System.Byte[]): System.String use System.Text.Encoding"
		alias
			"GetString"
		end

	get_chars_array_byte_int32_int32_array_char (bytes: ARRAY [INTEGER_8]; byte_index: INTEGER; byte_count: INTEGER; chars: ARRAY [CHARACTER]; char_index: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32, System.Char[], System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetChars"
		end

	get_encoder: SYSTEM_TEXT_ENCODER is
		external
			"IL signature (): System.Text.Encoder use System.Text.Encoding"
		alias
			"GetEncoder"
		end

	frozen convert_encoding_encoding_array_byte_int32 (src_encoding: SYSTEM_TEXT_ENCODING; dst_encoding: SYSTEM_TEXT_ENCODING; bytes: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Text.Encoding, System.Text.Encoding, System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Text.Encoding"
		alias
			"Convert"
		end

	get_bytes_array_char (chars: ARRAY [CHARACTER]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Char[]): System.Byte[] use System.Text.Encoding"
		alias
			"GetBytes"
		end

	get_byte_count (chars: ARRAY [CHARACTER]): INTEGER is
		external
			"IL signature (System.Char[]): System.Int32 use System.Text.Encoding"
		alias
			"GetByteCount"
		end

	get_bytes (s: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String): System.Byte[] use System.Text.Encoding"
		alias
			"GetBytes"
		end

	get_chars_array_byte_int32_int32 (bytes: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): ARRAY [CHARACTER] is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Char[] use System.Text.Encoding"
		alias
			"GetChars"
		end

	get_bytes_array_char_int32_int32_array_byte_int32 (chars: ARRAY [CHARACTER]; char_index: INTEGER; char_count: INTEGER; bytes: ARRAY [INTEGER_8]; byte_index: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32, System.Byte[], System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetBytes"
		end

	get_byte_count_string (s: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Text.Encoding"
		alias
			"GetByteCount"
		end

	frozen get_encoding_int32 (codepage: INTEGER): SYSTEM_TEXT_ENCODING is
		external
			"IL static signature (System.Int32): System.Text.Encoding use System.Text.Encoding"
		alias
			"GetEncoding"
		end

	get_byte_count_array_char_int32 (chars: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetByteCount"
		end

	get_char_count_array_byte_int32 (bytes: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Text.Encoding"
		alias
			"GetCharCount"
		end

	get_decoder: SYSTEM_TEXT_DECODER is
		external
			"IL signature (): System.Text.Decoder use System.Text.Encoding"
		alias
			"GetDecoder"
		end

end -- class SYSTEM_TEXT_ENCODING
