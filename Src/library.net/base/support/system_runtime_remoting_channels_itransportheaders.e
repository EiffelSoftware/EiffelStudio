indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.ITransportHeaders"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_item (key: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.Runtime.Remoting.Channels.ITransportHeaders"
		alias
			"get_Item"
		end

feature -- Element Change

	put_i_th (key: ANY; value: ANY) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.ITransportHeaders"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IEnumerator use System.Runtime.Remoting.Channels.ITransportHeaders"
		alias
			"GetEnumerator"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS
