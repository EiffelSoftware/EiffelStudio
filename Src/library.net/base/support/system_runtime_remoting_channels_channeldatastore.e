indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.ChannelDataStore"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_CHANNELDATASTORE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELDATASTORE

create
	make

feature {NONE} -- Initialization

	frozen make (channel_uris: ARRAY [STRING]) is
		external
			"IL creator signature (System.String[]) use System.Runtime.Remoting.Channels.ChannelDataStore"
		end

feature -- Access

	frozen get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"get_Item"
		end

	frozen get_channel_uris: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"get_ChannelUris"
		end

feature -- Element Change

	frozen set_channel_uris (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"set_ChannelUris"
		end

	frozen put_i_th (key: ANY; value: ANY) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.ChannelDataStore"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_CHANNELDATASTORE
