indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ObjectCreationDelegate"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_OBJECTCREATIONDELEGATE

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_objectcreationdelegate

feature {NONE} -- Initialization

	frozen make_objectcreationdelegate (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Runtime.InteropServices.ObjectCreationDelegate"
		end

feature -- Basic Operations

	begin_invoke (aggregator: POINTER; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.IntPtr, System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.InteropServices.ObjectCreationDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): POINTER is
		external
			"IL signature (System.IAsyncResult): System.IntPtr use System.Runtime.InteropServices.ObjectCreationDelegate"
		alias
			"EndInvoke"
		end

	invoke (aggregator: POINTER): POINTER is
		external
			"IL signature (System.IntPtr): System.IntPtr use System.Runtime.InteropServices.ObjectCreationDelegate"
		alias
			"Invoke"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_OBJECTCREATIONDELEGATE
