indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.EventHandler"

frozen external class
	SYSTEM_EVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_eventhandler

feature {NONE} -- Initialization

	frozen make_eventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.EventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_EVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.EventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.EventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.EventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.EventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_EVENTHANDLER
