indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ListChangedEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTHANDLER

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
	make_listchangedeventhandler

feature {NONE} -- Initialization

	frozen make_listchangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.ListChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.ListChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.ListChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.ListChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.ListChangedEventArgs): System.Void use System.ComponentModel.ListChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_LISTCHANGEDEVENTHANDLER
