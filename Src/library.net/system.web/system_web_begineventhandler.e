indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.BeginEventHandler"

frozen external class
	SYSTEM_WEB_BEGINEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
		rename
			equals as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			equals as equals_object
		end

create
	make_begineventhandler

feature {NONE} -- Initialization

	frozen make_begineventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.BeginEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_EVENTARGS; cb: SYSTEM_ASYNCCALLBACK; extra_data: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.EventArgs, System.AsyncCallback, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.BeginEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.IAsyncResult): System.IAsyncResult use System.Web.BeginEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_EVENTARGS; cb: SYSTEM_ASYNCCALLBACK; extra_data: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.EventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.BeginEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_BEGINEVENTHANDLER
