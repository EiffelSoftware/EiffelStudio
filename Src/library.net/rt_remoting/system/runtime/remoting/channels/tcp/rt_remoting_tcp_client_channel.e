indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_TCP_CLIENT_CHANNEL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICHANNEL_SENDER
	ICHANNEL

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (properties: IDICTIONARY; sink_provider: ICLIENT_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		end

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		end

	frozen make_1 (name: SYSTEM_STRING; sink_provider: ICLIENT_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.String, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		end

feature -- Access

	frozen get_channel_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"get_ChannelName"
		end

	frozen get_channel_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"get_ChannelPriority"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"ToString"
		end

	create_message_sink (url: SYSTEM_STRING; remote_channel_data: SYSTEM_OBJECT; object_uri: SYSTEM_STRING): IMESSAGE_SINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"CreateMessageSink"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"Equals"
		end

	frozen parse (url: SYSTEM_STRING; object_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_TCP_CLIENT_CHANNEL
