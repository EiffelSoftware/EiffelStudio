indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpServerChannel"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPSERVERCHANNEL

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVERHOOK
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELWITHPROPERTIES
		redefine
			get_keys,
			put_i_th,
			get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as ienumerable_get_enumerator
		end

create
	make_httpserverchannel_4,
	make_httpserverchannel,
	make_httpserverchannel_2,
	make_httpserverchannel_3,
	make_httpserverchannel_1

feature {NONE} -- Initialization

	frozen make_httpserverchannel_4 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		end

	frozen make_httpserverchannel is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		end

	frozen make_httpserverchannel_2 (name: STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		end

	frozen make_httpserverchannel_3 (name: STRING; port: INTEGER; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.String, System.Int32, System.Runtime.Remoting.Channels.IServerChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		end

	frozen make_httpserverchannel_1 (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		end

feature -- Access

	frozen get_channel_scheme: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_ChannelScheme"
		end

	get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_Item"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_Keys"
		end

	frozen get_wants_to_listen: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_WantsToListen"
		end

	frozen get_channel_data: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_ChannelData"
		end

	frozen get_channel_sink_chain: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_ChannelSinkChain"
		end

	frozen get_channel_priority: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_ChannelPriority"
		end

	frozen get_channel_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"get_ChannelName"
		end

feature -- Element Change

	frozen set_wants_to_listen (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"set_WantsToListen"
		end

	put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_urls_for_uri (object_uri: STRING): ARRAY [STRING] is
		external
			"IL signature (System.String): System.String[] use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"GetUrlsForUri"
		end

	frozen start_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"StartListening"
		end

	frozen get_channel_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"GetChannelUri"
		end

	frozen stop_listening (data: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"StopListening"
		end

	frozen add_hook_channel_uri (channel_uri: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"AddHookChannelUri"
		end

	frozen parse (url: STRING; object_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Http.HttpServerChannel"
		alias
			"Parse"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPSERVERCHANNEL
