indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IChannelDataStore"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELDATASTORE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_item (key: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.Runtime.Remoting.Channels.IChannelDataStore"
		alias
			"get_Item"
		end

	get_channel_uris: ARRAY [STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.Remoting.Channels.IChannelDataStore"
		alias
			"get_ChannelUris"
		end

feature -- Element Change

	put_i_th (key: ANY; value: ANY) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.IChannelDataStore"
		alias
			"set_Item"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELDATASTORE
