indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StatusBarDrawItemEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTHANDLER

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
	make_statusbardrawitemeventhandler

feature {NONE} -- Initialization

	frozen make_statusbardrawitemeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.StatusBarDrawItemEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; sbdevent: SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.StatusBarDrawItemEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.StatusBarDrawItemEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.StatusBarDrawItemEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; sbdevent: SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.StatusBarDrawItemEventArgs): System.Void use System.Windows.Forms.StatusBarDrawItemEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTHANDLER
