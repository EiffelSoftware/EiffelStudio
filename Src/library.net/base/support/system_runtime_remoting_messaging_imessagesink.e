indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.IMessageSink"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_next_sink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Messaging.IMessageSink"
		alias
			"get_NextSink"
		end

feature -- Basic Operations

	sync_process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Messaging.IMessageSink"
		alias
			"SyncProcessMessage"
		end

	async_process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; replySink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Messaging.IMessageSink"
		alias
			"AsyncProcessMessage"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK
