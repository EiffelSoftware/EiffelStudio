indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.BaseChannelWithProperties"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	BASE_CHANNEL_WITH_PROPERTIES

inherit
	BASE_CHANNEL_OBJECT_WITH_PROPERTIES
		redefine
			get_properties
		end
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

feature -- Access

	get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.BaseChannelWithProperties"
		alias
			"get_Properties"
		end

end -- class BASE_CHANNEL_WITH_PROPERTIES
