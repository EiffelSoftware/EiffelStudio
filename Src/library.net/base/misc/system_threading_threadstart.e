indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.ThreadStart"

frozen external class
	SYSTEM_THREADING_THREADSTART

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_threadstart

feature {NONE} -- Initialization

	frozen make_threadstart (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Threading.ThreadStart"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.ThreadStart"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
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

end -- class SYSTEM_THREADING_THREADSTART
