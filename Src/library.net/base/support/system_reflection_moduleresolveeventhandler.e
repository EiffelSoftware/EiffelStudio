indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ModuleResolveEventHandler"

frozen external class
	SYSTEM_REFLECTION_MODULERESOLVEEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_moduleresolveeventhandler

feature {NONE} -- Initialization

	frozen make_moduleresolveeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Reflection.ModuleResolveEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_RESOLVEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ResolveEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Reflection.ModuleResolveEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.IAsyncResult): System.Reflection.Module use System.Reflection.ModuleResolveEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_RESOLVEEVENTARGS): SYSTEM_REFLECTION_MODULE is
		external
			"IL signature (System.Object, System.ResolveEventArgs): System.Reflection.Module use System.Reflection.ModuleResolveEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_REFLECTION_MODULERESOLVEEVENTHANDLER
