indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CrossAppDomainDelegate"

frozen external class
	SYSTEM_CROSSAPPDOMAINDELEGATE

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_crossappdomaindelegate

feature {NONE} -- Initialization

	frozen make_crossappdomaindelegate (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.CrossAppDomainDelegate"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.CrossAppDomainDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.CrossAppDomainDelegate"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.CrossAppDomainDelegate"
		alias
			"Invoke"
		end

end -- class SYSTEM_CROSSAPPDOMAINDELEGATE
