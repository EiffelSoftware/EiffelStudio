indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.AsyncResult"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_ASYNCRESULT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IASYNCRESULT
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK

create {NONE}

feature -- Access

	get_async_wait_Handle: SYSTEM_THREADING_WAITHANDLE is
		external
			"IL signature (): System.Threading.WaitHandle use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_AsyncWaitHandle"
		end

	get_is_completed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_IsCompleted"
		end

	get_async_delegate: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_AsyncDelegate"
		end

	frozen get_end_invoke_called: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_EndInvokeCalled"
		end

	get_async_state: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_AsyncState"
		end

	frozen get_next_sink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_NextSink"
		end

	get_completed_synchronously: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_CompletedSynchronously"
		end

feature -- Element Change

	frozen set_end_invoke_called (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"set_EndInvokeCalled"
		end

feature -- Basic Operations

	get_reply_message: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"GetReplyMessage"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"GetHashCode"
		end

	set_message_ctrl (mc: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageCtrl): System.Void use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"SetMessageCtrl"
		end

	sync_process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"SyncProcessMessage"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"Equals"
		end

	async_process_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; replySink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"AsyncProcessMessage"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_ASYNCRESULT
