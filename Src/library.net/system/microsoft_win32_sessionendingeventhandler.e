indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.SessionEndingEventHandler"

frozen external class
	MICROSOFT_WIN32_SESSIONENDINGEVENTHANDLER

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
	make_sessionendingeventhandler

feature {NONE} -- Initialization

	frozen make_sessionendingeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use Microsoft.Win32.SessionEndingEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: MICROSOFT_WIN32_SESSIONENDINGEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, Microsoft.Win32.SessionEndingEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use Microsoft.Win32.SessionEndingEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Microsoft.Win32.SessionEndingEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: MICROSOFT_WIN32_SESSIONENDINGEVENTARGS) is
		external
			"IL signature (System.Object, Microsoft.Win32.SessionEndingEventArgs): System.Void use Microsoft.Win32.SessionEndingEventHandler"
		alias
			"Invoke"
		end

end -- class MICROSOFT_WIN32_SESSIONENDINGEVENTHANDLER
