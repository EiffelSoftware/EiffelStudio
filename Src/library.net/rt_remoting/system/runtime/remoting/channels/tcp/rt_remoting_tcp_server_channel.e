indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_TCP_SERVER_CHANNEL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICHANNEL_RECEIVER
	ICHANNEL

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (properties: IDICTIONARY; sink_provider: ISERVER_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

	frozen make_2 (name: SYSTEM_STRING; port: INTEGER; sink_provider: ISERVER_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.String, System.Int32, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

	frozen make (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

	frozen make_1 (name: SYSTEM_STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

feature -- Access

	frozen get_channel_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"get_ChannelName"
		end

	frozen get_channel_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"get_ChannelPriority"
		end

	frozen get_channel_data: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"get_ChannelData"
		end

feature -- Basic Operations

	frozen stop_listening (data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"StopListening"
		end

	get_urls_for_uri (object_uri: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"GetUrlsForUri"
		end

	frozen get_channel_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"GetChannelUri"
		end

	frozen parse (url: SYSTEM_STRING; object_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"Parse"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"Equals"
		end

	frozen start_listening (data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"StartListening"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_TCP_SERVER_CHANNEL
