indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.GlobalProxySelection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_GLOBAL_PROXY_SELECTION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.GlobalProxySelection"
		end

feature -- Access

	frozen get_select: SYSTEM_DLL_IWEB_PROXY is
		external
			"IL static signature (): System.Net.IWebProxy use System.Net.GlobalProxySelection"
		alias
			"get_Select"
		end

feature -- Element Change

	frozen set_select (value: SYSTEM_DLL_IWEB_PROXY) is
		external
			"IL static signature (System.Net.IWebProxy): System.Void use System.Net.GlobalProxySelection"
		alias
			"set_Select"
		end

feature -- Basic Operations

	frozen get_empty_web_proxy: SYSTEM_DLL_IWEB_PROXY is
		external
			"IL static signature (): System.Net.IWebProxy use System.Net.GlobalProxySelection"
		alias
			"GetEmptyWebProxy"
		end

end -- class SYSTEM_DLL_GLOBAL_PROXY_SELECTION
