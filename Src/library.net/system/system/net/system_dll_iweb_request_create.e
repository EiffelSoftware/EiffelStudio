indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.IWebRequestCreate"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IWEB_REQUEST_CREATE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_ (uri: SYSTEM_DLL_URI): SYSTEM_DLL_WEB_REQUEST is
		external
			"IL deferred signature (System.Uri): System.Net.WebRequest use System.Net.IWebRequestCreate"
		alias
			"Create"
		end

end -- class SYSTEM_DLL_IWEB_REQUEST_CREATE
