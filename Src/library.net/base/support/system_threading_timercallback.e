indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.TimerCallback"

frozen external class
	SYSTEM_THREADING_TIMERCALLBACK

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_timercallback

feature {NONE} -- Initialization

	frozen make_timercallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Threading.TimerCallback"
		end

feature -- Basic Operations

	begin_invoke (state: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.TimerCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.TimerCallback"
		alias
			"EndInvoke"
		end

	invoke (state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Threading.TimerCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_THREADING_TIMERCALLBACK
