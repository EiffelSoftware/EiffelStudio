indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.TimerCallback"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TIMER_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_timer_callback

feature {NONE} -- Initialization

	frozen make_timer_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Threading.TimerCallback"
		end

feature -- Basic Operations

	begin_invoke (state: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.TimerCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.TimerCallback"
		alias
			"EndInvoke"
		end

	invoke (state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Threading.TimerCallback"
		alias
			"Invoke"
		end

end -- class TIMER_CALLBACK
