indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.TimerElapsedEventHandler"

frozen external class
	MICROSOFT_WIN32_TIMERELAPSEDEVENTHANDLER

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
	make_timerelapsedeventhandler

feature {NONE} -- Initialization

	frozen make_timerelapsedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use Microsoft.Win32.TimerElapsedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: MICROSOFT_WIN32_TIMERELAPSEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, Microsoft.Win32.TimerElapsedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use Microsoft.Win32.TimerElapsedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Microsoft.Win32.TimerElapsedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: MICROSOFT_WIN32_TIMERELAPSEDEVENTARGS) is
		external
			"IL signature (System.Object, Microsoft.Win32.TimerElapsedEventArgs): System.Void use Microsoft.Win32.TimerElapsedEventHandler"
		alias
			"Invoke"
		end

end -- class MICROSOFT_WIN32_TIMERELAPSEDEVENTHANDLER
