indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IChannelReceiver"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICHANNEL_RECEIVER

inherit
	ICHANNEL

feature -- Access

	get_channel_data: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"get_ChannelData"
		end

feature -- Basic Operations

	stop_listening (data: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"StopListening"
		end

	get_urls_for_uri (object_uri: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (System.String): System.String[] use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"GetUrlsForUri"
		end

	start_listening (data: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Remoting.Channels.IChannelReceiver"
		alias
			"StartListening"
		end

end -- class ICHANNEL_RECEIVER
