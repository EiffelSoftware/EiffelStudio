indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpChannel"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_HTTP_CHANNEL

inherit
	BASE_CHANNEL_WITH_PROPERTIES
		redefine
			get_keys,
			set_item,
			get_item,
			get_properties
		end
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICHANNEL_RECEIVER
	ICHANNEL
	ICHANNEL_SENDER
	ICHANNEL_RECEIVER_HOOK

create
	make_rt_remoting_http_channel_2,
	make_rt_remoting_http_channel,
	make_rt_remoting_http_channel_1

feature {NONE} -- Initialization

	frozen make_rt_remoting_http_channel_2 (properties: IDICTIONARY; client_sink_provider: ICLIENT_CHANNEL_SINK_PROVIDER; server_sink_provider: ISERVER_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpChannel"
		end

	frozen make_rt_remoting_http_channel is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpChannel"
		end

	frozen make_rt_remoting_http_channel_1 (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Channels.Http.HttpChannel"
		end

feature -- Access

	frozen get_channel_scheme: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelScheme"
		end

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_Item"
		end

	get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_Keys"
		end

	frozen get_wants_to_listen: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_WantsToListen"
		end

	frozen get_channel_data: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelData"
		end

	frozen get_channel_sink_chain: ISERVER_CHANNEL_SINK is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelSinkChain"
		end

	frozen get_channel_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelPriority"
		end

	frozen get_channel_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelName"
		end

	get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_Properties"
		end

feature -- Element Change

	frozen set_wants_to_listen (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"set_WantsToListen"
		end

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen get_urls_for_uri (object_uri: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (System.String): System.String[] use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"GetUrlsForUri"
		end

	frozen start_listening (data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"StartListening"
		end

	frozen create_message_sink (url: SYSTEM_STRING; remote_channel_data: SYSTEM_OBJECT; object_uri: SYSTEM_STRING): IMESSAGE_SINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"CreateMessageSink"
		end

	frozen stop_listening (data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"StopListening"
		end

	frozen add_hook_channel_uri (channel_uri: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"AddHookChannelUri"
		end

	frozen parse (url: SYSTEM_STRING; object_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"Parse"
		end

end -- class RT_REMOTING_HTTP_CHANNEL
