indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.ThreadPool"

frozen external class
	SYSTEM_THREADING_THREADPOOL

create {NONE}

feature -- Basic Operations

	frozen unsafe_queue_user_work_item (call_back: SYSTEM_THREADING_WAITCALLBACK; state: ANY): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitCallback, System.Object): System.Boolean use System.Threading.ThreadPool"
		alias
			"UnsafeQueueUserWorkItem"
		end

	frozen register_wait_for_single_object (wait_object: SYSTEM_THREADING_WAITHANDLE; call_back: SYSTEM_THREADING_WAITORTIMERCALLBACK; state: ANY; timeout: SYSTEM_TIMESPAN; execute_only_once: BOOLEAN): SYSTEM_THREADING_REGISTEREDWAITHANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.TimeSpan, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"RegisterWaitForSingleObject"
		end

	frozen queue_user_work_item_wait_callback_object (call_back: SYSTEM_THREADING_WAITCALLBACK; state: ANY): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitCallback, System.Object): System.Boolean use System.Threading.ThreadPool"
		alias
			"QueueUserWorkItem"
		end

	frozen register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int32 (wait_object: SYSTEM_THREADING_WAITHANDLE; call_back: SYSTEM_THREADING_WAITORTIMERCALLBACK; state: ANY; milliseconds_time_out_interval: INTEGER; execute_only_once: BOOLEAN): SYSTEM_THREADING_REGISTEREDWAITHANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int32, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"RegisterWaitForSingleObject"
		end

	frozen queue_user_work_item (call_back: SYSTEM_THREADING_WAITCALLBACK): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitCallback): System.Boolean use System.Threading.ThreadPool"
		alias
			"QueueUserWorkItem"
		end

	frozen unsafe_register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int32 (wait_object: SYSTEM_THREADING_WAITHANDLE; call_back: SYSTEM_THREADING_WAITORTIMERCALLBACK; state: ANY; milliseconds_time_out_interval: INTEGER; execute_only_once: BOOLEAN): SYSTEM_THREADING_REGISTEREDWAITHANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int32, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"UnsafeRegisterWaitForSingleObject"
		end

	frozen unsafe_register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int64 (wait_object: SYSTEM_THREADING_WAITHANDLE; call_back: SYSTEM_THREADING_WAITORTIMERCALLBACK; state: ANY; milliseconds_time_out_interval: INTEGER_64; execute_only_once: BOOLEAN): SYSTEM_THREADING_REGISTEREDWAITHANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int64, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"UnsafeRegisterWaitForSingleObject"
		end

	frozen unsafe_register_wait_for_single_object (wait_object: SYSTEM_THREADING_WAITHANDLE; call_back: SYSTEM_THREADING_WAITORTIMERCALLBACK; state: ANY; timeout: SYSTEM_TIMESPAN; execute_only_once: BOOLEAN): SYSTEM_THREADING_REGISTEREDWAITHANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.TimeSpan, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"UnsafeRegisterWaitForSingleObject"
		end

	frozen register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int64 (wait_object: SYSTEM_THREADING_WAITHANDLE; call_back: SYSTEM_THREADING_WAITORTIMERCALLBACK; state: ANY; milliseconds_time_out_interval: INTEGER_64; execute_only_once: BOOLEAN): SYSTEM_THREADING_REGISTEREDWAITHANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int64, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"RegisterWaitForSingleObject"
		end

	frozen bind_handle (os_handle: POINTER): BOOLEAN is
		external
			"IL static signature (System.IntPtr): System.Boolean use System.Threading.ThreadPool"
		alias
			"BindHandle"
		end

end -- class SYSTEM_THREADING_THREADPOOL
