indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.HelpEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_HELPEVENTHANDLER

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
	make_helpeventhandler

feature {NONE} -- Initialization

	frozen make_helpeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.HelpEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; hlpevent: SYSTEM_WINDOWS_FORMS_HELPEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.HelpEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.HelpEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.HelpEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; hlpevent: SYSTEM_WINDOWS_FORMS_HELPEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.HelpEventArgs): System.Void use System.Windows.Forms.HelpEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_HELPEVENTHANDLER
