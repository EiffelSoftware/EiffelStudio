indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.ChannelServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CHANNEL_SERVICES

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_registered_channels: NATIVE_ARRAY [ICHANNEL] is
		external
			"IL static signature (): System.Runtime.Remoting.Channels.IChannel[] use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"get_RegisteredChannels"
		end

feature -- Basic Operations

	frozen register_channel (chnl: ICHANNEL) is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IChannel): System.Void use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"RegisterChannel"
		end

	frozen get_urls_for_object (obj: MARSHAL_BY_REF_OBJECT): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.MarshalByRefObject): System.String[] use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"GetUrlsForObject"
		end

	frozen create_server_channel_sink_chain (provider: ISERVER_CHANNEL_SINK_PROVIDER; channel: ICHANNEL_RECEIVER): ISERVER_CHANNEL_SINK is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IServerChannelSinkProvider, System.Runtime.Remoting.Channels.IChannelReceiver): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"CreateServerChannelSinkChain"
		end

	frozen sync_dispatch_message (msg: IMESSAGE): IMESSAGE is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"SyncDispatchMessage"
		end

	frozen dispatch_message (sink_stack: ISERVER_CHANNEL_SINK_STACK; msg: IMESSAGE; reply_msg: IMESSAGE): SERVER_PROCESSING is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessage&): System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"DispatchMessage"
		end

	frozen unregister_channel (chnl: ICHANNEL) is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IChannel): System.Void use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"UnregisterChannel"
		end

	frozen get_channel_sink_properties (obj: SYSTEM_OBJECT): IDICTIONARY is
		external
			"IL static signature (System.Object): System.Collections.IDictionary use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"GetChannelSinkProperties"
		end

	frozen get_channel (name: SYSTEM_STRING): ICHANNEL is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Channels.IChannel use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"GetChannel"
		end

	frozen async_dispatch_message (msg: IMESSAGE; reply_sink: IMESSAGE_SINK): IMESSAGE_CTRL is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"AsyncDispatchMessage"
		end

end -- class CHANNEL_SERVICES
