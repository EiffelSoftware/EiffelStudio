indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebProxy"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_WEB_PROXY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_IWEB_PROXY
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make,
	make_7,
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make_1,
	make_9,
	make_8

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.WebProxy"
		end

	frozen make_7 (address: SYSTEM_STRING; bypass_on_local: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.Net.WebProxy"
		end

	frozen make_6 (address: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Net.WebProxy"
		end

	frozen make_5 (host: SYSTEM_STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Net.WebProxy"
		end

	frozen make_4 (address: SYSTEM_DLL_URI; bypass_on_local: BOOLEAN; bypass_list: NATIVE_ARRAY [SYSTEM_STRING]; credentials: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL creator signature (System.Uri, System.Boolean, System.String[], System.Net.ICredentials) use System.Net.WebProxy"
		end

	frozen make_3 (address: SYSTEM_DLL_URI; bypass_on_local: BOOLEAN; bypass_list: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.Uri, System.Boolean, System.String[]) use System.Net.WebProxy"
		end

	frozen make_2 (address: SYSTEM_DLL_URI; bypass_on_local: BOOLEAN) is
		external
			"IL creator signature (System.Uri, System.Boolean) use System.Net.WebProxy"
		end

	frozen make_1 (address: SYSTEM_DLL_URI) is
		external
			"IL creator signature (System.Uri) use System.Net.WebProxy"
		end

	frozen make_9 (address: SYSTEM_STRING; bypass_on_local: BOOLEAN; bypass_list: NATIVE_ARRAY [SYSTEM_STRING]; credentials: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL creator signature (System.String, System.Boolean, System.String[], System.Net.ICredentials) use System.Net.WebProxy"
		end

	frozen make_8 (address: SYSTEM_STRING; bypass_on_local: BOOLEAN; bypass_list: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String, System.Boolean, System.String[]) use System.Net.WebProxy"
		end

feature -- Access

	frozen get_address: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.WebProxy"
		alias
			"get_Address"
		end

	frozen get_bypass_proxy_on_local: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.WebProxy"
		alias
			"get_BypassProxyOnLocal"
		end

	frozen get_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL signature (): System.Net.ICredentials use System.Net.WebProxy"
		alias
			"get_Credentials"
		end

	frozen get_bypass_list: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Net.WebProxy"
		alias
			"get_BypassList"
		end

	frozen get_bypass_array_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Net.WebProxy"
		alias
			"get_BypassArrayList"
		end

feature -- Element Change

	frozen set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.WebProxy"
		alias
			"set_Credentials"
		end

	frozen set_address (value: SYSTEM_DLL_URI) is
		external
			"IL signature (System.Uri): System.Void use System.Net.WebProxy"
		alias
			"set_Address"
		end

	frozen set_bypass_list (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Net.WebProxy"
		alias
			"set_BypassList"
		end

	frozen set_bypass_proxy_on_local (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.WebProxy"
		alias
			"set_BypassProxyOnLocal"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.WebProxy"
		alias
			"GetHashCode"
		end

	frozen get_default_proxy: SYSTEM_DLL_WEB_PROXY is
		external
			"IL static signature (): System.Net.WebProxy use System.Net.WebProxy"
		alias
			"GetDefaultProxy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebProxy"
		alias
			"ToString"
		end

	frozen get_proxy (destination: SYSTEM_DLL_URI): SYSTEM_DLL_URI is
		external
			"IL signature (System.Uri): System.Uri use System.Net.WebProxy"
		alias
			"GetProxy"
		end

	frozen is_bypassed (host: SYSTEM_DLL_URI): BOOLEAN is
		external
			"IL signature (System.Uri): System.Boolean use System.Net.WebProxy"
		alias
			"IsBypassed"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.WebProxy"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebProxy"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Net.WebProxy"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_WEB_PROXY
