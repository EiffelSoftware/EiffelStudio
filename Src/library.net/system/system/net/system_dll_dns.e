indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Dns"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DNS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen end_resolve (async_result: IASYNC_RESULT): SYSTEM_DLL_IPHOST_ENTRY is
		external
			"IL static signature (System.IAsyncResult): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"EndResolve"
		end

	frozen resolve (host_name: SYSTEM_STRING): SYSTEM_DLL_IPHOST_ENTRY is
		external
			"IL static signature (System.String): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"Resolve"
		end

	frozen get_host_by_name (host_name: SYSTEM_STRING): SYSTEM_DLL_IPHOST_ENTRY is
		external
			"IL static signature (System.String): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"GetHostByName"
		end

	frozen begin_resolve (host_name: SYSTEM_STRING; request_callback: ASYNC_CALLBACK; state_object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL static signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Dns"
		alias
			"BeginResolve"
		end

	frozen get_host_by_address (address: SYSTEM_DLL_IPADDRESS): SYSTEM_DLL_IPHOST_ENTRY is
		external
			"IL static signature (System.Net.IPAddress): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"GetHostByAddress"
		end

	frozen get_host_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Net.Dns"
		alias
			"GetHostName"
		end

	frozen end_get_host_by_name (async_result: IASYNC_RESULT): SYSTEM_DLL_IPHOST_ENTRY is
		external
			"IL static signature (System.IAsyncResult): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"EndGetHostByName"
		end

	frozen get_host_by_address_string (address: SYSTEM_STRING): SYSTEM_DLL_IPHOST_ENTRY is
		external
			"IL static signature (System.String): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"GetHostByAddress"
		end

	frozen begin_get_host_by_name (host_name: SYSTEM_STRING; request_callback: ASYNC_CALLBACK; state_object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL static signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Dns"
		alias
			"BeginGetHostByName"
		end

end -- class SYSTEM_DLL_DNS
