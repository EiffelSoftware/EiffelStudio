indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.PowerModeChangedEventHandler"

frozen external class
	MICROSOFT_WIN32_POWERMODECHANGEDEVENTHANDLER

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
	make_powermodechangedeventhandler

feature {NONE} -- Initialization

	frozen make_powermodechangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use Microsoft.Win32.PowerModeChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: MICROSOFT_WIN32_POWERMODECHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, Microsoft.Win32.PowerModeChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use Microsoft.Win32.PowerModeChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use Microsoft.Win32.PowerModeChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: MICROSOFT_WIN32_POWERMODECHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, Microsoft.Win32.PowerModeChangedEventArgs): System.Void use Microsoft.Win32.PowerModeChangedEventHandler"
		alias
			"Invoke"
		end

end -- class MICROSOFT_WIN32_POWERMODECHANGEDEVENTHANDLER
