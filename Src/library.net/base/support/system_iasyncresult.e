indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IAsyncResult"

deferred external class
	SYSTEM_IASYNCRESULT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_completed_synchronously: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.IAsyncResult"
		alias
			"get_CompletedSynchronously"
		end

	get_async_state: ANY is
		external
			"IL deferred signature (): System.Object use System.IAsyncResult"
		alias
			"get_AsyncState"
		end

	get_async_wait_handle: SYSTEM_THREADING_WAITHANDLE is
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

end -- class SYSTEM_IASYNCRESULT
