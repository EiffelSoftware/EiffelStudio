indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.ChannelServices"

frozen external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_CHANNELSERVICES

create {NONE}

feature -- Access

	frozen get_registered_channels: ARRAY [SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL] is
		external
			"IL static signature (): System.Runtime.Remoting.Channels.IChannel[] use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"get_RegisteredChannels"
		end

feature -- Basic Operations

	frozen sync_dispatch_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"SyncDispatchMessage"
		end

	frozen get_urls_for_object (obj: SYSTEM_MARSHALBYREFOBJECT): ARRAY [STRING] is
		external
			"IL static signature (System.MarshalByRefObject): System.String[] use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"GetUrlsForObject"
		end

	frozen async_dispatch_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; replySink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"AsyncDispatchMessage"
		end

	frozen get_channel (name: STRING): SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Channels.IChannel use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"GetChannel"
		end

	frozen register_channel (chnl: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL) is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IChannel): System.Void use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"RegisterChannel"
		end

	frozen unregister_channel (chnl: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL) is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IChannel): System.Void use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"UnregisterChannel"
		end

	frozen get_channel_sink_properties (obj: ANY): SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL static signature (System.Object): System.Collections.IDictionary use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"GetChannelSinkProperties"
		end

	frozen dispatch_message (sinkStack: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK; msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; replyMsg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): INTEGER is
		external
			"IL static signature (System.Runtime.Remoting.Channels.IServerChannelSinkStack, System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessage&): enum System.Runtime.Remoting.Channels.ServerProcessing use System.Runtime.Remoting.Channels.ChannelServices"
		alias
			"DispatchMessage"
		ensure
			valid_server_processing: Result = 0 or Result = 1 or Result = 2
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_CHANNELSERVICES
