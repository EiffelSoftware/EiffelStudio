indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.IDynamicMessageSink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IDYNAMIC_MESSAGE_SINK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	process_message_start (req_msg: IMESSAGE; b_cli_side: BOOLEAN; b_async: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Boolean, System.Boolean): System.Void use System.Runtime.Remoting.Contexts.IDynamicMessageSink"
		alias
			"ProcessMessageStart"
		end

	process_message_finish (reply_msg: IMESSAGE; b_cli_side: BOOLEAN; b_async: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Boolean, System.Boolean): System.Void use System.Runtime.Remoting.Contexts.IDynamicMessageSink"
		alias
			"ProcessMessageFinish"
		end

end -- class IDYNAMIC_MESSAGE_SINK
