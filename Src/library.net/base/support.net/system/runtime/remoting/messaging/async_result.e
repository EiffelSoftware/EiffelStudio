indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.AsyncResult"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ASYNC_RESULT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IASYNC_RESULT
	IMESSAGE_SINK

create {NONE}

feature -- Access

	get_async_delegate: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_AsyncDelegate"
		end

	get_completed_synchronously: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_CompletedSynchronously"
		end

	frozen get_end_invoke_called: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_EndInvokeCalled"
		end

	frozen get_next_sink: IMESSAGE_SINK is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_NextSink"
		end

	get_async_wait_handle: WAIT_HANDLE is
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

	get_async_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"get_AsyncState"
		end

feature -- Element Change

	frozen set_end_invoke_called (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"set_EndInvokeCalled"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"ToString"
		end

	async_process_message (msg: IMESSAGE; reply_sink: IMESSAGE_SINK): IMESSAGE_CTRL is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageCtrl use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"AsyncProcessMessage"
		end

	set_message_ctrl (mc: IMESSAGE_CTRL) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageCtrl): System.Void use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"SetMessageCtrl"
		end

	sync_process_message (msg: IMESSAGE): IMESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"SyncProcessMessage"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"Equals"
		end

	get_reply_message: IMESSAGE is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"GetReplyMessage"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.AsyncResult"
		alias
			"Finalize"
		end

end -- class ASYNC_RESULT
