indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IAsyncResult"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IASYNC_RESULT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_completed_synchronously: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IAsyncResult"
		alias
			"get_CompletedSynchronously"
		end

	get_async_state: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.IAsyncResult"
		alias
			"get_AsyncState"
		end

	get_async_wait_handle: WAIT_HANDLE is
		external
			"IL deferred signature (): System.Threading.WaitHandle use System.IAsyncResult"
		alias
			"get_AsyncWaitHandle"
		end

	get_is_completed: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IAsyncResult"
		alias
			"get_IsCompleted"
		end

end -- class IASYNC_RESULT
