indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Timers.ElapsedEventHandler"

frozen external class
	SYSTEM_TIMERS_ELAPSEDEVENTHANDLER

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
	make_elapsedeventhandler

feature {NONE} -- Initialization

	frozen make_elapsedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Timers.ElapsedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_TIMERS_ELAPSEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Timers.ElapsedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Timers.ElapsedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Timers.ElapsedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_TIMERS_ELAPSEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Timers.ElapsedEventArgs): System.Void use System.Timers.ElapsedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_TIMERS_ELAPSEDEVENTHANDLER
