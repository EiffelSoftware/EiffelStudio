indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.IMessage"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL deferred signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.IMessage"
		alias
			"get_Properties"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE
