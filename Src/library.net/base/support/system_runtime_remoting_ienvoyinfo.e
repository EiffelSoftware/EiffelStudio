indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.IEnvoyInfo"

deferred external class
	SYSTEM_RUNTIME_REMOTING_IENVOYINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_envoy_sinks: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.IEnvoyInfo"
		alias
			"get_EnvoySinks"
		end

feature -- Element Change

	set_envoy_sinks (value: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Void use System.Runtime.Remoting.IEnvoyInfo"
		alias
			"set_EnvoySinks"
		end

end -- class SYSTEM_RUNTIME_REMOTING_IENVOYINFO
