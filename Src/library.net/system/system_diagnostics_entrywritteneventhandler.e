indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EntryWrittenEventHandler"

frozen external class
	SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
		rename
			is_equal as equals_object	
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_entrywritteneventhandler

feature {NONE} -- Initialization

	frozen make_entrywritteneventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Diagnostics.EntryWrittenEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Diagnostics.EntryWrittenEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Diagnostics.EntryWrittenEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Diagnostics.EntryWrittenEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTARGS) is
		external
			"IL signature (System.Object, System.Diagnostics.EntryWrittenEventArgs): System.Void use System.Diagnostics.EntryWrittenEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTHANDLER
