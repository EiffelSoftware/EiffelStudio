indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_TCP_TCPSERVERCHANNEL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

	frozen make_2 (name: STRING; port: INTEGER; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.String, System.Int32, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

	frozen make (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

	frozen make_1 (name: STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		end

feature -- Access

	frozen get_channel_name: STRING is
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

	frozen get_channel_data: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"get_ChannelData"
		end

feature -- Basic Operations

	frozen stop_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"StopListening"
		end

	get_urls_for_uri (object_uri: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"GetUrlsForUri"
		end

	frozen get_channel_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"GetChannelUri"
		end

	frozen parse (url: STRING; object_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"Parse"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Tcp.TcpServerChannel"
		alias
			"Equals"
		end

	frozen start_listening (data: ANY) is
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

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_TCP_TCPSERVERCHANNEL
