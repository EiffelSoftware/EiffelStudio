indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpClientChannel"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_HTTP_CLIENT_CHANNEL

inherit
	BASE_CHANNEL_WITH_PROPERTIES
		redefine
			get_keys,
			set_item,
			get_item
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
	ICHANNEL_SENDER
	ICHANNEL

create
	make_rt_remoting_http_client_channel_1,
	make_rt_remoting_http_client_channel,
	make_rt_remoting_http_client_channel_2

feature {NONE} -- Initialization

	frozen make_rt_remoting_http_client_channel_1 (name: SYSTEM_STRING; sink_provider: ICLIENT_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.String, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		end

	frozen make_rt_remoting_http_client_channel is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		end

	frozen make_rt_remoting_http_client_channel_2 (properties: IDICTIONARY; sink_provider: ICLIENT_CHANNEL_SINK_PROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		end

feature -- Access

	frozen get_channel_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"get_ChannelName"
		end

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"get_Item"
		end

	get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"get_Keys"
		end

	frozen get_channel_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"get_ChannelPriority"
		end

feature -- Element Change

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"set_Item"
		end

feature -- Basic Operations

	create_message_sink (url: SYSTEM_STRING; remote_channel_data: SYSTEM_OBJECT; object_uri: SYSTEM_STRING): IMESSAGE_SINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"CreateMessageSink"
		end

	frozen parse (url: SYSTEM_STRING; object_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"Parse"
		end

end -- class RT_REMOTING_HTTP_CLIENT_CHANNEL
