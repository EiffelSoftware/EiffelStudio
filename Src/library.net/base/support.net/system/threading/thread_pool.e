indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadPool"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	THREAD_POOL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen unsafe_queue_user_work_item (call_back: WAIT_CALLBACK; state: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitCallback, System.Object): System.Boolean use System.Threading.ThreadPool"
		alias
			"UnsafeQueueUserWorkItem"
		end

	frozen register_wait_for_single_object (wait_object: WAIT_HANDLE; call_back: WAIT_OR_TIMER_CALLBACK; state: SYSTEM_OBJECT; timeout: TIME_SPAN; execute_only_once: BOOLEAN): REGISTERED_WAIT_HANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.TimeSpan, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"RegisterWaitForSingleObject"
		end

	frozen queue_user_work_item_wait_callback_object (call_back: WAIT_CALLBACK; state: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitCallback, System.Object): System.Boolean use System.Threading.ThreadPool"
		alias
			"QueueUserWorkItem"
		end

	frozen get_available_threads (worker_threads: INTEGER; completion_port_threads: INTEGER) is
		external
			"IL static signature (System.Int32&, System.Int32&): System.Void use System.Threading.ThreadPool"
		alias
			"GetAvailableThreads"
		end

	frozen register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int32 (wait_object: WAIT_HANDLE; call_back: WAIT_OR_TIMER_CALLBACK; state: SYSTEM_OBJECT; milliseconds_time_out_interval: INTEGER; execute_only_once: BOOLEAN): REGISTERED_WAIT_HANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int32, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"RegisterWaitForSingleObject"
		end

	frozen get_max_threads (worker_threads: INTEGER; completion_port_threads: INTEGER) is
		external
			"IL static signature (System.Int32&, System.Int32&): System.Void use System.Threading.ThreadPool"
		alias
			"GetMaxThreads"
		end

	frozen queue_user_work_item (call_back: WAIT_CALLBACK): BOOLEAN is
		external
			"IL static signature (System.Threading.WaitCallback): System.Boolean use System.Threading.ThreadPool"
		alias
			"QueueUserWorkItem"
		end

	frozen unsafe_register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int32 (wait_object: WAIT_HANDLE; call_back: WAIT_OR_TIMER_CALLBACK; state: SYSTEM_OBJECT; milliseconds_time_out_interval: INTEGER; execute_only_once: BOOLEAN): REGISTERED_WAIT_HANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int32, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"UnsafeRegisterWaitForSingleObject"
		end

	frozen unsafe_register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int64 (wait_object: WAIT_HANDLE; call_back: WAIT_OR_TIMER_CALLBACK; state: SYSTEM_OBJECT; milliseconds_time_out_interval: INTEGER_64; execute_only_once: BOOLEAN): REGISTERED_WAIT_HANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.Int64, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"UnsafeRegisterWaitForSingleObject"
		end

	frozen unsafe_register_wait_for_single_object (wait_object: WAIT_HANDLE; call_back: WAIT_OR_TIMER_CALLBACK; state: SYSTEM_OBJECT; timeout: TIME_SPAN; execute_only_once: BOOLEAN): REGISTERED_WAIT_HANDLE is
		external
			"IL static signature (System.Threading.WaitHandle, System.Threading.WaitOrTimerCallback, System.Object, System.TimeSpan, System.Boolean): System.Threading.RegisteredWaitHandle use System.Threading.ThreadPool"
		alias
			"UnsafeRegisterWaitForSingleObject"
		end

	frozen register_wait_for_single_object_wait_handle_wait_or_timer_callback_object_int64 (wait_object: WAIT_HANDLE; call_back: WAIT_OR_TIMER_CALLBACK; state: SYSTEM_OBJECT; milliseconds_time_out_interval: INTEGER_64; execute_only_once: BOOLEAN): REGISTERED_WAIT_HANDLE is
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

end -- class THREAD_POOL
