indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.GlobalProxySelection"

external class
	SYSTEM_NET_GLOBALPROXYSELECTION

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.GlobalProxySelection"
		end

feature -- Access

	frozen get_select: SYSTEM_NET_IWEBPROXY is
		external
			"IL static signature (): System.Net.IWebProxy use System.Net.GlobalProxySelection"
		alias
			"get_Select"
		end

feature -- Element Change

	frozen set_select (value: SYSTEM_NET_IWEBPROXY) is
		external
			"IL static signature (System.Net.IWebProxy): System.Void use System.Net.GlobalProxySelection"
		alias
			"set_Select"
		end

feature -- Basic Operations

	frozen get_empty_web_proxy: SYSTEM_NET_IWEBPROXY is
		external
			"IL static signature (): System.Net.IWebProxy use System.Net.GlobalProxySelection"
		alias
			"GetEmptyWebProxy"
		end

end -- class SYSTEM_NET_GLOBALPROXYSELECTION
