indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_BINARY_CLIENT_FORMATTER_SINK_PROVIDER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLIENT_FORMATTER_SINK_PROVIDER
	ICLIENT_CHANNEL_SINK_PROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		end

	frozen make_1 (properties: IDICTIONARY; provider_data: ICOLLECTION) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.ICollection) use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		end

feature -- Access

	frozen get_next: ICLIENT_CHANNEL_SINK_PROVIDER is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IClientChannelSinkProvider use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	frozen set_next (value: ICLIENT_CHANNEL_SINK_PROVIDER) is
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

	frozen create_sink (channel: ICHANNEL_SENDER; url: SYSTEM_STRING; remote_channel_data: SYSTEM_OBJECT): ICLIENT_CHANNEL_SINK is
		external
			"IL signature (System.Runtime.Remoting.Channels.IChannelSender, System.String, System.Object): System.Runtime.Remoting.Channels.IClientChannelSink use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"CreateSink"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.BinaryClientFormatterSinkProvider"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class RT_REMOTING_BINARY_CLIENT_FORMATTER_SINK_PROVIDER
