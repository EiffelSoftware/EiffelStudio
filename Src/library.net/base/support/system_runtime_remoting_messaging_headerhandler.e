indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.HeaderHandler"

frozen external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADERHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_headerhandler

feature {NONE} -- Initialization

	frozen make_headerhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Runtime.Remoting.Messaging.HeaderHandler"
		end

feature -- Basic Operations

	begin_invoke (headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Runtime.Remoting.Messaging.Header[], System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.Remoting.Messaging.HeaderHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): ANY is
		external
			"IL signature (System.IAsyncResult): System.Object use System.Runtime.Remoting.Messaging.HeaderHandler"
		alias
			"EndInvoke"
		end

	invoke (headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]): ANY is
		external
			"IL signature (System.Runtime.Remoting.Messaging.Header[]): System.Object use System.Runtime.Remoting.Messaging.HeaderHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADERHANDLER
