indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileSystemEventHandler"

frozen external class
	SYSTEM_IO_FILESYSTEMEVENTHANDLER

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
	make_filesystemeventhandler

feature {NONE} -- Initialization

	frozen make_filesystemeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.IO.FileSystemEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_IO_FILESYSTEMEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.IO.FileSystemEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.FileSystemEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.FileSystemEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_IO_FILESYSTEMEVENTARGS) is
		external
			"IL signature (System.Object, System.IO.FileSystemEventArgs): System.Void use System.IO.FileSystemEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_IO_FILESYSTEMEVENTHANDLER
