indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.IEnvoyInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IENVOY_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_envoy_sinks: IMESSAGE_SINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.IEnvoyInfo"
		alias
			"get_EnvoySinks"
		end

feature -- Element Change

	set_envoy_sinks (value: IMESSAGE_SINK) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Void use System.Runtime.Remoting.IEnvoyInfo"
		alias
			"set_EnvoySinks"
		end

end -- class IENVOY_INFO
