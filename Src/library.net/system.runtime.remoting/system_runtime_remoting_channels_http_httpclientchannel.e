indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.Http.HttpClientChannel"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPCLIENTCHANNEL

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNEL
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELWITHPROPERTIES
		redefine
			get_keys,
			set_item,
			get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make_httpclientchannel,
	make_httpclientchannel_2,
	make_httpclientchannel_1

feature {NONE} -- Initialization

	frozen make_httpclientchannel is
		external
			"IL creator use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		end

	frozen make_httpclientchannel_2 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		end

	frozen make_httpclientchannel_1 (name: STRING; sink_provider: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER) is
		external
			"IL creator signature (System.String, System.Runtime.Remoting.Channels.IClientChannelSinkProvider) use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		end

feature -- Access

	frozen get_channel_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"get_ChannelName"
		end

	get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"get_Item"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	set_item (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"set_Item"
		end

feature -- Basic Operations

	create_message_sink (url: STRING; remote_channel_data: ANY; object_uri: STRING): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.String, System.Object, System.String&): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"CreateMessageSink"
		end

	frozen parse (url: STRING; object_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String&): System.String use System.Runtime.Remoting.Channels.Http.HttpClientChannel"
		alias
			"Parse"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_HTTP_HTTPCLIENTCHANNEL
