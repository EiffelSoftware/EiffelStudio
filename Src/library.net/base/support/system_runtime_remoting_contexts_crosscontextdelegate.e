indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Contexts.CrossContextDelegate"

frozen external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_CROSSCONTEXTDELEGATE

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_crosscontextdelegate

feature {NONE} -- Initialization

	frozen make_crosscontextdelegate (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		alias
			"Invoke"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_CROSSCONTEXTDELEGATE
