indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Contexts.IContributeServerContextSink"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTESERVERCONTEXTSINK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_server_context_sink (nextSink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.IContributeServerContextSink"
		alias
			"GetServerContextSink"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTESERVERCONTEXTSINK
