indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BINARYCLIENTFORMATTERSINKPROVIDER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTFORMATTERSINKPROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		end

	frozen make_1 (properties: SYSTEM_COLLECTIONS_IDICTIONARY; provider_data: SYSTEM_COLLECTIONS_ICOLLECTION) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.ICollection) use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		end

feature -- Access

	frozen get_next: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IClientChannelSinkProvider use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	frozen set_next (value: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINKPROVIDER) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IClientChannelSinkProvider): System.Void use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"GetHashCode"
		end

	frozen create_sink (channel: SYSTEM_RUNTIME_REMOTING_CHANNELS_ICHANNELSENDER; url: STRING; remote_channel_data: ANY): SYSTEM_RUNTIME_REMOTING_CHANNELS_ICLIENTCHANNELSINK is
		external
			"IL signature (System.Runtime.Remoting.Channels.IChannelSender, System.String, System.Object): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"CreateSink"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_BINARYCLIENTFORMATTERSINKPROVIDER
