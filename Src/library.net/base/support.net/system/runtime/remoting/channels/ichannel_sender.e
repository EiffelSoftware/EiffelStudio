indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IChannelSender"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICHANNEL_SENDER

inherit
	ICHANNEL

feature -- Basic Operations

	create_message_sink (url: SYSTEM_STRING; remote_channel_data: SYSTEM_OBJECT; object_uri: SYSTEM_STRING): IMESSAGE_SINK is
		external
			"IL deferred signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.IChannelSender"
		alias
			"CreateMessageSink"
		end

end -- class ICHANNEL_SENDER
