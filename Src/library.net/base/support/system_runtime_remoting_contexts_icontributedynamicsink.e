indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Contexts.IContributeDynamicSink"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTEDYNAMICSINK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_dynamic_sink: SYSTEM_RUNTIME_REMOTING_CONTEXTS_IDYNAMICMESSAGESINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Contexts.IDynamicMessageSink use System.Runtime.Remoting.Contexts.IContributeDynamicSink"
		alias
			"GetDynamicSink"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTEDYNAMICSINK
