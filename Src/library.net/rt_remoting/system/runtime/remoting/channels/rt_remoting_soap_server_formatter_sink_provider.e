indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_SOAP_SERVER_FORMATTER_SINK_PROVIDER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERVER_FORMATTER_SINK_PROVIDER
	ISERVER_CHANNEL_SINK_PROVIDER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		end

	frozen make_1 (properties: IDICTIONARY; provider_data: ICOLLECTION) is
		external
			"IL creator signature (System.Collections.IDictionary, System.Collections.ICollection) use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		end

feature -- Access

	frozen get_next: ISERVER_CHANNEL_SINK_PROVIDER is
		external
			"IL signature (): System.Runtime.Remoting.Channels.IServerChannelSinkProvider use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"get_Next"
		end

feature -- Element Change

	frozen set_next (value: ISERVER_CHANNEL_SINK_PROVIDER) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSinkProvider): System.Void use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"set_Next"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"GetHashCode"
		end

	frozen create_sink (channel: ICHANNEL_RECEIVER): ISERVER_CHANNEL_SINK is
		external
			"IL signature (System.Runtime.Remoting.Channels.IChannelReceiver): System.Runtime.Remoting.Channels.IServerChannelSink use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"CreateSink"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"ToString"
		end

	frozen get_channel_data (channel_data: ICHANNEL_DATA_STORE) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IChannelDataStore): System.Void use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"GetChannelData"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.SoapServerFormatterSinkProvider"
		alias
			"Finalize"
		end

end -- class RT_REMOTING_SOAP_SERVER_FORMATTER_SINK_PROVIDER
