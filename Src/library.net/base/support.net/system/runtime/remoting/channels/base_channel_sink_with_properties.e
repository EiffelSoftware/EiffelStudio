indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.BaseChannelSinkWithProperties"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	BASE_CHANNEL_SINK_WITH_PROPERTIES

inherit
	BASE_CHANNEL_OBJECT_WITH_PROPERTIES
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

end -- class BASE_CHANNEL_SINK_WITH_PROPERTIES
