indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyValueChangedEventHandler"

frozen external class
	SYSTEM_WINDOWS_FORMS_PROPERTYVALUECHANGEDEVENTHANDLER

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
	make_propertyvaluechangedeventhandler

feature {NONE} -- Initialization

	frozen make_propertyvaluechangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.PropertyValueChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (s: ANY; e: SYSTEM_WINDOWS_FORMS_PROPERTYVALUECHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Windows.Forms.PropertyValueChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.PropertyValueChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.PropertyValueChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (s: ANY; e: SYSTEM_WINDOWS_FORMS_PROPERTYVALUECHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.PropertyValueChangedEventArgs): System.Void use System.Windows.Forms.PropertyValueChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYVALUECHANGEDEVENTHANDLER
