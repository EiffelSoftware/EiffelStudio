indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.MessageSurrogateFilter"

frozen external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_MESSAGESURROGATEFILTER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_messagesurrogatefilter

feature {NONE} -- Initialization

	frozen make_messagesurrogatefilter (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		end

feature -- Basic Operations

	begin_invoke (key: STRING; value: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.String, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		alias
			"EndInvoke"
		end

	invoke (key: STRING; value: ANY): BOOLEAN is
		external
			"IL signature (System.String, System.Object): System.Boolean use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		alias
			"Invoke"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_MESSAGESURROGATEFILTER
