indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.WaitOrTimerCallback"

frozen external class
	SYSTEM_THREADING_WAITORTIMERCALLBACK

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_waitortimercallback

feature {NONE} -- Initialization

	frozen make_waitortimercallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Threading.WaitOrTimerCallback"
		end

feature -- Basic Operations

	begin_invoke (state: ANY; was_signalled: BOOLEAN; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Boolean, System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.WaitOrTimerCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.WaitOrTimerCallback"
		alias
			"EndInvoke"
		end

	invoke (state: ANY; was_signalled: BOOLEAN) is
		external
			"IL signature (System.Object, System.Boolean): System.Void use System.Threading.WaitOrTimerCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_THREADING_WAITORTIMERCALLBACK
