indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.IContributeObjectSink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONTRIBUTE_OBJECT_SINK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_object_sink (obj: MARSHAL_BY_REF_OBJECT; next_sink: IMESSAGE_SINK): IMESSAGE_SINK is
		external
			"IL deferred signature (System.MarshalByRefObject, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.IContributeObjectSink"
		alias
			"GetObjectSink"
		end

end -- class ICONTRIBUTE_OBJECT_SINK
