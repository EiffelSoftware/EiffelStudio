indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.ChannelDataStore"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CHANNEL_DATA_STORE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICHANNEL_DATA_STORE

create
	make

feature {NONE} -- Initialization

	frozen make (channel_uris: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String[]) use System.Runtime.Remoting.Channels.ChannelDataStore"
		end

feature -- Access

	frozen get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"get_Item"
		end

	frozen get_channel_uris: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"get_ChannelUris"
		end

feature -- Element Change

	frozen set_channel_uris (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"set_ChannelUris"
		end

	frozen set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"Finalize"
		end

end -- class CHANNEL_DATA_STORE
