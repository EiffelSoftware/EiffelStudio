indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.SinkProviderData"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SINK_PROVIDER_DATA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Channels.SinkProviderData"
		end

feature -- Access

	frozen get_children: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Runtime.Remoting.Channels.SinkProviderData"
		alias
			"get_Children"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.SinkProviderData"
		alias
			"get_Name"
		end

	frozen get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.SinkProviderData"
		alias
			"get_Properties"
		end

end -- class SINK_PROVIDER_DATA
