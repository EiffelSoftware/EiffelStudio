indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Uri"

external class
	SYSTEM_URI

inherit
	SYSTEM_MARSHALBYREFOBJECT
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data,
			is_equal as equals_object
		end

create
	make_uri_2,
	make_uri,
	make_uri_3,
	make_uri_1

feature {NONE} -- Initialization

	frozen make_uri_2 (base_uri: SYSTEM_URI; relative_uri: STRING) is
		external
			"IL creator signature (System.Uri, System.String) use System.Uri"
		end

	frozen make_uri (uri_string: STRING) is
		external
			"IL creator signature (System.String) use System.Uri"
		end

	frozen make_uri_3 (base_uri: SYSTEM_URI; relative_uri: STRING; dont_escape: BOOLEAN) is
		external
			"IL creator signature (System.Uri, System.String, System.Boolean) use System.Uri"
		end

	frozen make_uri_1 (uri_string: STRING; dont_escape: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Uri"
		end

feature -- Access

	frozen get_local_path: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_LocalPath"
		end

	frozen uri_scheme_file: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeFile"
		end

	frozen get_host_name_type: SYSTEM_URIHOSTNAMETYPE is
		external
			"IL signature (): System.UriHostNameType use System.Uri"
		alias
			"get_HostNameType"
		end

	frozen get_host: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_Host"
		end

	frozen scheme_delimiter: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"SchemeDelimiter"
		end

	frozen uri_scheme_news: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeNews"
		end

	frozen uri_scheme_mailto: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeMailto"
		end

	frozen uri_scheme_gopher: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeGopher"
		end

	frozen get_absolute_path: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_AbsolutePath"
		end

	frozen get_user_info: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_UserInfo"
		end

	frozen uri_scheme_nntp: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeNntp"
		end

	frozen uri_scheme_ftp: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeFtp"
		end

	frozen get_authority: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_Authority"
		end

	frozen get_is_unc: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Uri"
		alias
			"get_IsUnc"
		end

	frozen get_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.Uri"
		alias
			"get_Port"
		end

	frozen get_is_file: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Uri"
		alias
			"get_IsFile"
		end

	frozen get_is_loopback: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Uri"
		alias
			"get_IsLoopback"
		end

	frozen get_scheme: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_Scheme"
		end

	frozen get_absolute_uri: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_AbsoluteUri"
		end

	frozen uri_scheme_http: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeHttp"
		end

	frozen get_segments: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Uri"
		alias
			"get_Segments"
		end

	frozen get_fragment: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_Fragment"
		end

	frozen uri_scheme_https: STRING is
		external
			"IL static_field signature :System.String use System.Uri"
		alias
			"UriSchemeHttps"
		end

	frozen get_path_and_query: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_PathAndQuery"
		end

	frozen get_query: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"get_Query"
		end

	frozen get_user_escaped: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Uri"
		alias
			"get_UserEscaped"
		end

	frozen get_is_default_port: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Uri"
		alias
			"get_IsDefaultPort"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Uri"
		alias
			"ToString"
		end

	frozen from_hex (digit: CHARACTER): INTEGER is
		external
			"IL static signature (System.Char): System.Int32 use System.Uri"
		alias
			"FromHex"
		end

	frozen check_scheme_name (scheme_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Uri"
		alias
			"CheckSchemeName"
		end

	frozen check_host_name (name: STRING): SYSTEM_URIHOSTNAMETYPE is
		external
			"IL static signature (System.String): System.UriHostNameType use System.Uri"
		alias
			"CheckHostName"
		end

	frozen hex_unescape (pattern: STRING; index: INTEGER): CHARACTER is
		external
			"IL static signature (System.String, System.Int32&): System.Char use System.Uri"
		alias
			"HexUnescape"
		end

	frozen hex_escape (character: CHARACTER): STRING is
		external
			"IL static signature (System.Char): System.String use System.Uri"
		alias
			"HexEscape"
		end

	frozen make_relative (to_uri: SYSTEM_URI): STRING is
		external
			"IL signature (System.Uri): System.String use System.Uri"
		alias
			"MakeRelative"
		end

	frozen is_hex_digit (character: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Uri"
		alias
			"IsHexDigit"
		end

	frozen get_left_part (part: SYSTEM_URIPARTIAL): STRING is
		external
			"IL signature (System.UriPartial): System.String use System.Uri"
		alias
			"GetLeftPart"
		end

	equals_object (comparand: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Uri"
		alias
			"Equals"
		end

	frozen is_hex_encoding (pattern: STRING; index: INTEGER): BOOLEAN is
		external
			"IL static signature (System.String, System.Int32): System.Boolean use System.Uri"
		alias
			"IsHexEncoding"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Uri"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Uri"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	frozen escape_string (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Uri"
		alias
			"EscapeString"
		end

	is_reserved_character (character: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Uri"
		alias
			"IsReservedCharacter"
		end

	check_security is
		external
			"IL signature (): System.Void use System.Uri"
		alias
			"CheckSecurity"
		end

	unescape (path: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Uri"
		alias
			"Unescape"
		end

	frozen is_excluded_character (character: CHARACTER): BOOLEAN is
		external
			"IL static signature (System.Char): System.Boolean use System.Uri"
		alias
			"IsExcludedCharacter"
		end

	parse is
		external
			"IL signature (): System.Void use System.Uri"
		alias
			"Parse"
		end

	canonicalize is
		external
			"IL signature (): System.Void use System.Uri"
		alias
			"Canonicalize"
		end

	is_bad_file_system_character (character: CHARACTER): BOOLEAN is
		external
			"IL signature (System.Char): System.Boolean use System.Uri"
		alias
			"IsBadFileSystemCharacter"
		end

	escape is
		external
			"IL signature (): System.Void use System.Uri"
		alias
			"Escape"
		end

end -- class SYSTEM_URI
