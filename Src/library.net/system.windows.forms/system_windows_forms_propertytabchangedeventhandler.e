indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyTabChangedEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_PROPERTYTABCHANGEDEVENTHANDLER

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
	make_propertytabchangedeventhandler

feature {NONE} -- Initialization

	frozen make_propertytabchangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.PropertyTabChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (s: ANY; e: SYSTEM_WINDOWS_FORMS_PROPERTYTABCHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.PropertyTabChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.PropertyTabChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.PropertyTabChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (s: ANY; e: SYSTEM_WINDOWS_FORMS_PROPERTYTABCHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.PropertyTabChangedEventArgs): System.Void use System.Windows.Forms.PropertyTabChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYTABCHANGEDEVENTHANDLER
