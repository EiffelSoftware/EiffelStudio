indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IMessageSink"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMESSAGE_SINK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_next_sink: IMESSAGE_SINK is
		external
			"IL deferred signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Messaging.IMessageSink"
		alias
			"get_NextSink"
		end

feature -- Basic Operations

	async_process_message (msg: IMESSAGE; reply_sink: IMESSAGE_SINK): IMESSAGE_CTRL is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Messaging.IMessageSink"
		alias
			"AsyncProcessMessage"
		end

	sync_process_message (msg: IMESSAGE): IMESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Messaging.IMessageSink"
		alias
			"SyncProcessMessage"
		end

end -- class IMESSAGE_SINK
