indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.BaseChannelWithProperties"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELWITHPROPERTIES

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELOBJECTWITHPROPERTIES
		redefine
			get_properties
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end

feature -- Access

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.BaseChannelWithProperties"
		alias
			"get_Properties"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELWITHPROPERTIES
