indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMESSAGE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_properties: IDICTIONARY is
		external
			"IL deferred signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.IMessage"
		alias
			"get_Properties"
		end

end -- class IMESSAGE
