indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.WaitOrTimerCallback"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WAIT_OR_TIMER_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_wait_or_timer_callback

feature {NONE} -- Initialization

	frozen make_wait_or_timer_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Threading.WaitOrTimerCallback"
		end

feature -- Basic Operations

	begin_invoke (state: SYSTEM_OBJECT; timed_out: BOOLEAN; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Boolean, System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.WaitOrTimerCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.WaitOrTimerCallback"
		alias
			"EndInvoke"
		end

	invoke (state: SYSTEM_OBJECT; timed_out: BOOLEAN) is
		external
			"IL signature (System.Object, System.Boolean): System.Void use System.Threading.WaitOrTimerCallback"
		alias
			"Invoke"
		end

end -- class WAIT_OR_TIMER_CALLBACK
