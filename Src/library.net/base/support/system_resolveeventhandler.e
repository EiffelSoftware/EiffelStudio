indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ResolveEventHandler"

frozen external class
	SYSTEM_RESOLVEEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_resolveeventhandler

feature {NONE} -- Initialization

	frozen make_resolveeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ResolveEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; args: SYSTEM_RESOLVEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ResolveEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ResolveEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.IAsyncResult): System.Reflection.Assembly use System.ResolveEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; args: SYSTEM_RESOLVEEVENTARGS): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL signature (System.Object, System.ResolveEventArgs): System.Reflection.Assembly use System.ResolveEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_RESOLVEEVENTHANDLER
