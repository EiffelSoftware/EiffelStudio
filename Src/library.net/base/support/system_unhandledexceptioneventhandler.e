indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UnhandledExceptionEventHandler"

frozen external class
	SYSTEM_UNHANDLEDEXCEPTIONEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_unhandledexceptioneventhandler

feature {NONE} -- Initialization

	frozen make_unhandledexceptioneventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.UnhandledExceptionEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_UNHANDLEDEXCEPTIONEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.UnhandledExceptionEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.UnhandledExceptionEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.UnhandledExceptionEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_UNHANDLEDEXCEPTIONEVENTARGS) is
		external
			"IL signature (System.Object, System.UnhandledExceptionEventArgs): System.Void use System.UnhandledExceptionEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_UNHANDLEDEXCEPTIONEVENTHANDLER
