indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadStart"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	THREAD_START

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_thread_start

feature {NONE} -- Initialization

	frozen make_thread_start (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Threading.ThreadStart"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.ThreadStart"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.ThreadStart"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Threading.ThreadStart"
		alias
			"Invoke"
		end

end -- class THREAD_START
