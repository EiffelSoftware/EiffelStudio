indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.ITransportHeaders"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ITRANSPORT_HEADERS

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.Runtime.Remoting.Channels.ITransportHeaders"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.ITransportHeaders"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_enumerator: IENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IEnumerator use System.Runtime.Remoting.Channels.ITransportHeaders"
		alias
			"GetEnumerator"
		end

end -- class ITRANSPORT_HEADERS
