indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpChannel"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPCHANNEL

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELWITHPROPERTIES
		redefine
			get_keys,
			put_i_th,
			get_item,
			get_properties
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVERHOOK
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL

create
	make_httpchannel,
	make_httpchannel_2,
	make_httpchannel_1

feature {NONE} -- Initialization

	frozen make_httpchannel is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpChannel"
		end

	frozen make_httpchannel_2 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; client_sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER; server_sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpChannel"
		end

	frozen make_httpchannel_1 (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Channels.Http.HttpChannel"
		end

feature -- Access

	frozen get_channel_scheme: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelScheme"
		end

	get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_Item"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	frozen get_channel_data: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelData"
		end

	frozen get_channel_sink_chain: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
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

	frozen get_channel_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"get_ChannelName"
		end

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
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

	put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen get_urls_for_uri (object_uri: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"GetUrlsForUri"
		end

	frozen start_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"StartListening"
		end

	frozen create_message_sink (url: STRING; remote_channel_data: ANY; object_uri: STRING): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"CreateMessageSink"
		end

	frozen stop_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"StopListening"
		end

	frozen add_hook_channel_uri (channel_uri: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"AddHookChannelUri"
		end

	frozen parse (url: STRING; object_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Http.HttpChannel"
		alias
			"Parse"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPCHANNEL
