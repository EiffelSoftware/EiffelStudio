indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.PropertyChangedEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTHANDLER

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
	make_propertychangedeventhandler

feature {NONE} -- Initialization

	frozen make_propertychangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.PropertyChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.PropertyChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.PropertyChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.PropertyChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.PropertyChangedEventArgs): System.Void use System.ComponentModel.PropertyChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTHANDLER
