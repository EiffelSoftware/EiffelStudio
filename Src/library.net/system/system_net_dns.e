indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Dns"

frozen external class
	SYSTEM_NET_DNS

create {NONE}

feature -- Basic Operations

	frozen begin_get_host_by_name (host_name: STRING; request_callback: SYSTEM_ASYNCCALLBACK; state_object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL static signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Dns"
		alias
			"BeginGetHostByName"
		end

	frozen end_resolve (async_result: SYSTEM_IASYNCRESULT): SYSTEM_NET_IPHOSTENTRY is
		external
			"IL static signature (System.IAsyncResult): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"EndResolve"
		end

	frozen resolve (host_name: STRING): SYSTEM_NET_IPHOSTENTRY is
		external
			"IL static signature (System.String): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"Resolve"
		end

	frozen get_host_by_name (host_name: STRING): SYSTEM_NET_IPHOSTENTRY is
		external
			"IL static signature (System.String): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"GetHostByName"
		end

	frozen begin_resolve (host_name: STRING; request_callback: SYSTEM_ASYNCCALLBACK; state_object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL static signature (System.String, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Dns"
		alias
			"BeginResolve"
		end

	frozen get_host_by_address (address: SYSTEM_NET_IPADDRESS): SYSTEM_NET_IPHOSTENTRY is
		external
			"IL static signature (System.Net.IPAddress): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"GetHostByAddress"
		end

	frozen get_host_name: STRING is
		external
			"IL static signature (): System.String use System.Net.Dns"
		alias
			"GetHostName"
		end

	frozen end_get_host_by_name (async_result: SYSTEM_IASYNCRESULT): SYSTEM_NET_IPHOSTENTRY is
		external
			"IL static signature (System.IAsyncResult): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"EndGetHostByName"
		end

	frozen get_host_by_address_string (address: STRING): SYSTEM_NET_IPHOSTENTRY is
		external
			"IL static signature (System.String): System.Net.IPHostEntry use System.Net.Dns"
		alias
			"GetHostByAddress"
		end

	frozen ip_to_string (address: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Net.Dns"
		alias
			"IpToString"
		end

end -- class SYSTEM_NET_DNS
