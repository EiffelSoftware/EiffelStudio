indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_TCP_TCPCLIENTCHANNEL

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

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		end

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		end

	frozen make_1 (name: STRING; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.String, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		end

feature -- Access

	frozen get_channel_name: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"ToString"
		end

	create_message_sink (url: STRING; remote_channel_data: ANY; object_uri: STRING): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"CreateMessageSink"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.Tcp.TcpClientChannel"
		alias
			"Equals"
		end

	frozen parse (url: STRING; object_uri: STRING): STRING is
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

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_TCP_TCPCLIENTCHANNEL
