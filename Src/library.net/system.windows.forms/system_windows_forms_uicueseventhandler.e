indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UICuesEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_UICUESEVENTHANDLER

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
	make_uicueseventhandler

feature {NONE} -- Initialization

	frozen make_uicueseventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.UICuesEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_WINDOWS_FORMS_UICUESEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.UICuesEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.UICuesEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.UICuesEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_WINDOWS_FORMS_UICUESEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.UICuesEventArgs): System.Void use System.Windows.Forms.UICuesEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_UICUESEVENTHANDLER
