indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpUtility"

frozen external class
	SYSTEM_WEB_HTTPUTILITY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.HttpUtility"
		end

feature -- Basic Operations

	frozen url_decode_to_bytes_array_byte_int32 (bytes: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen url_decode_to_bytes (bytes: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[]): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen url_encode_to_bytes_string_encoding (str: STRING; e: SYSTEM_TEXT_ENCODING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String, System.Text.Encoding): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen html_encode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL static signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpUtility"
		alias
			"HtmlEncode"
		end

	frozen url_encode_unicode_to_bytes (str: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeUnicodeToBytes"
		end

	frozen url_encode_to_bytes_string (str: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen url_encode_string_encoding (str: STRING; e: SYSTEM_TEXT_ENCODING): STRING is
		external
			"IL static signature (System.String, System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen html_decode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL static signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpUtility"
		alias
			"HtmlDecode"
		end

	frozen url_decode (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

	frozen html_attribute_encode (s: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"HtmlAttributeEncode"
		end

	frozen url_decode_to_bytes_string (str: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen url_encode_unicode (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"UrlEncodeUnicode"
		end

	frozen url_decode_array_byte_encoding (bytes: ARRAY [INTEGER_8]; e: SYSTEM_TEXT_ENCODING): STRING is
		external
			"IL static signature (System.Byte[], System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

	frozen html_attribute_encode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL static signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpUtility"
		alias
			"HtmlAttributeEncode"
		end

	frozen html_decode (s: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"HtmlDecode"
		end

	frozen url_encode_to_bytes (bytes: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[]): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen url_encode_string (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen html_encode (s: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.HttpUtility"
		alias
			"HtmlEncode"
		end

	frozen url_encode_array_byte_int32 (bytes: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen url_decode_string_encoding (str: STRING; e: SYSTEM_TEXT_ENCODING): STRING is
		external
			"IL static signature (System.String, System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

	frozen url_encode_to_bytes_array_byte_int32 (bytes: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlEncodeToBytes"
		end

	frozen url_encode (bytes: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Web.HttpUtility"
		alias
			"UrlEncode"
		end

	frozen url_decode_to_bytes_string_encoding (str: STRING; e: SYSTEM_TEXT_ENCODING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String, System.Text.Encoding): System.Byte[] use System.Web.HttpUtility"
		alias
			"UrlDecodeToBytes"
		end

	frozen url_decode_array_byte_int32 (bytes: ARRAY [INTEGER_8]; offset: INTEGER; count: INTEGER; e: SYSTEM_TEXT_ENCODING): STRING is
		external
			"IL static signature (System.Byte[], System.Int32, System.Int32, System.Text.Encoding): System.String use System.Web.HttpUtility"
		alias
			"UrlDecode"
		end

end -- class SYSTEM_WEB_HTTPUTILITY
