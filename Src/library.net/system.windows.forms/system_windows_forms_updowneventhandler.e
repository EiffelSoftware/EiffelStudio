indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UpDownEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_UPDOWNEVENTHANDLER

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
	make_updowneventhandler

feature {NONE} -- Initialization

	frozen make_updowneventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.UpDownEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: ANY; e: SYSTEM_WINDOWS_FORMS_UPDOWNEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.UpDownEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.UpDownEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.UpDownEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: ANY; e: SYSTEM_WINDOWS_FORMS_UPDOWNEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.UpDownEventArgs): System.Void use System.Windows.Forms.UpDownEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_UPDOWNEVENTHANDLER
