indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.IWebRequestCreate"

deferred external class
	SYSTEM_NET_IWEBREQUESTCREATE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	Create_ (uri: SYSTEM_URI): SYSTEM_NET_WEBREQUEST is
		external
			"IL deferred signature (System.Uri): System.Net.WebRequest use System.Net.IWebRequestCreate"
		alias
			"Create"
		end

end -- class SYSTEM_NET_IWEBREQUESTCREATE
