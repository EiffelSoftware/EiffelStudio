indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Contexts.IDynamicMessageSink"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_IDYNAMICMESSAGESINK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	process_message_finish (replyMsg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; bCliSide: BOOLEAN; bAsync: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Boolean, System.Boolean): System.Void use System.Runtime.Remoting.Contexts.IDynamicMessageSink"
		alias
			"ProcessMessageFinish"
		end

	process_message_start (reqMsg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; bCliSide: BOOLEAN; bAsync: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Boolean, System.Boolean): System.Void use System.Runtime.Remoting.Contexts.IDynamicMessageSink"
		alias
			"ProcessMessageStart"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_IDYNAMICMESSAGESINK
