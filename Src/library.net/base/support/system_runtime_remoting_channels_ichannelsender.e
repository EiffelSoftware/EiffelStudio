indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.IChannelSender"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL

feature -- Basic Operations

	create_message_sink (url: STRING; remoteChannelData: ANY; objectURI: STRING): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL deferred signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.IChannelSender"
		alias
			"CreateMessageSink"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER
