indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"

external class
	SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLCHANNELSINKPROVIDER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		end

	frozen make_1 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; provider_data: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.ICollection) use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		end

feature -- Access

	frozen get_next: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IServerChannelSinkProvider use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	frozen set_next (value: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKPROVIDER) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSinkProvider): System.Void use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"GetHashCode"
		end

	frozen create_sink (channel: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELRECEIVER): SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK is
		external
			"IL signature (System.Runtime.Remoting.Channels.IChannelReceiver): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"CreateSink"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"ToString"
		end

	frozen get_channel_data (local_channel_data: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELDATASTORE) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IChannelDataStore): System.Void use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"GetChannelData"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.MetadataServices.SdlChannelSinkProvider"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SDLCHANNELSINKPROVIDER
