indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.AssemblyLoadEventHandler"

frozen external class
	SYSTEM_ASSEMBLYLOADEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_assemblyloadeventhandler

feature {NONE} -- Initialization

	frozen make_assemblyloadeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.AssemblyLoadEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; args: SYSTEM_ASSEMBLYLOADEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.AssemblyLoadEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.AssemblyLoadEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.AssemblyLoadEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; args: SYSTEM_ASSEMBLYLOADEVENTARGS) is
		external
			"IL signature (System.Object, System.AssemblyLoadEventArgs): System.Void use System.AssemblyLoadEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_ASSEMBLYLOADEVENTHANDLER
