indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.IContributeDynamicSink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONTRIBUTE_DYNAMIC_SINK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_dynamic_sink: IDYNAMIC_MESSAGE_SINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Contexts.IDynamicMessageSink use System.Runtime.Remoting.Contexts.IContributeDynamicSink"
		alias
			"GetDynamicSink"
		end

end -- class ICONTRIBUTE_DYNAMIC_SINK
