indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.RenamedEventHandler"

frozen external class
	SYSTEM_IO_RENAMEDEVENTHANDLER

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
	make_renamedeventhandler

feature {NONE} -- Initialization

	frozen make_renamedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.IO.RenamedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_IO_RENAMEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.IO.RenamedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.RenamedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.RenamedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_IO_RENAMEDEVENTARGS) is
		external
			"IL signature (System.Object, System.IO.RenamedEventArgs): System.Void use System.IO.RenamedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_IO_RENAMEDEVENTHANDLER
