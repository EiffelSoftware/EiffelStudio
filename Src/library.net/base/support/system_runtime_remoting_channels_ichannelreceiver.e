indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IChannelReceiver"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL

feature -- Access

	get_channel_data: ANY is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"get_ChannelData"
		end

feature -- Basic Operations

	stop_listening (data: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"StopListening"
		end

	get_urls_for_uri (object_uri: STRING): ARRAY [STRING] is
		external
			"IL deferred signature (System.String): System.String[] use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"GetUrlsForUri"
		end

	start_listening (data: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"StartListening"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER
