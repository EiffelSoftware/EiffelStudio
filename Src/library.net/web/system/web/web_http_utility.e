indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpUtility"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_UTILITY

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.HttpUtility"
		end

feature -- Basic Operations

	frozen url_decode_to_bytes_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen url_decode_to_bytes (str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen html_encode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL static signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpUtility"
		alias
			"HtmlEncode"
		end

	frozen url_encode_unicode_to_bytes (str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeUnicodeToBytes"
		end

	frozen url_encode_array_byte (bytes: NATIVE_ARRAY [INTEGER_8]): SYSTEM_STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen url_encode_string_encoding (str: SYSTEM_STRING; e: ENCODING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen url_decode_string_encoding (str: SYSTEM_STRING; e: ENCODING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

	frozen html_decode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL static signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpUtility"
		alias
			"HtmlDecode"
		end

	frozen url_decode (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

	frozen html_attribute_encode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"HtmlAttributeEncode"
		end

	frozen url_encode_unicode (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"UrlEncodeUnicode"
		end

	frozen url_decode_array_byte_encoding (bytes: NATIVE_ARRAY [INTEGER_8]; e: ENCODING): SYSTEM_STRING is
		external
			"IL static signature (System.Byte[], System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

	frozen url_encode_to_bytes_string_encoding (str: SYSTEM_STRING; e: ENCODING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String, System.Text.Encoding): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen html_decode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"HtmlDecode"
		end

	frozen url_encode_to_bytes_array_byte (bytes: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[]): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen url_encode_to_bytes (str: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen url_decode_to_bytes_array_byte (bytes: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[]): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen html_encode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"HtmlEncode"
		end

	frozen url_encode_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen html_attribute_encode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL static signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpUtility"
		alias
			"HtmlAttributeEncode"
		end

	frozen url_encode_to_bytes_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen url_encode (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen url_decode_to_bytes_string_encoding (str: SYSTEM_STRING; e: ENCODING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String, System.Text.Encoding): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen url_decode_array_byte_int32 (bytes: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; e: ENCODING): SYSTEM_STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32, System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

end -- class WEB_HTTP_UTILITY
