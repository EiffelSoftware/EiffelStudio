indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.NavigateEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTHANDLER

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
	make_navigateeventhandler

feature {NONE} -- Initialization

	frozen make_navigateeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.NavigateEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; ne: SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.NavigateEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.NavigateEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.NavigateEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; ne: SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.NavigateEventArgs): System.Void use System.Windows.Forms.NavigateEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTHANDLER
