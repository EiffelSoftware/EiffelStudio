indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Tcp.TcpChannel"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_TCP_TCPCHANNEL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; client_sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER; server_sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		end

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		end

	frozen make_1 (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		end

feature -- Access

	frozen get_channel_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"get_ChannelName"
		end

	frozen get_channel_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"get_ChannelPriority"
		end

	frozen get_channel_data: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"get_ChannelData"
		end

feature -- Basic Operations

	frozen stop_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"StopListening"
		end

	frozen get_urls_for_uri (object_uri: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"GetUrlsForUri"
		end

	frozen parse (url: STRING; object_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"Parse"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"Equals"
		end

	frozen create_message_sink (url: STRING; remote_channel_data: ANY; object_uri: STRING): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"CreateMessageSink"
		end

	frozen start_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"StartListening"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpChannel"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_TCP_TCPCHANNEL
