indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IChannelDataStore"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICHANNEL_DATA_STORE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.Runtime.Remoting.Channels.IChannelDataStore"
		alias
			"get_Item"
		end

	get_channel_uris: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL deferred signature (): System.String[] use System.Runtime.Remoting.Channels.IChannelDataStore"
		alias
			"get_ChannelUris"
		end

feature -- Element Change

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.IChannelDataStore"
		alias
			"set_Item"
		end

end -- class ICHANNEL_DATA_STORE
