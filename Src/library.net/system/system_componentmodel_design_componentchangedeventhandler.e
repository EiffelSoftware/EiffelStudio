indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ComponentChangedEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTHANDLER

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
	make_componentchangedeventhandler

feature {NONE} -- Initialization

	frozen make_componentchangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.Design.ComponentChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.Design.ComponentChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.ComponentChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.Design.ComponentChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.Design.ComponentChangedEventArgs): System.Void use System.ComponentModel.Design.ComponentChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTCHANGEDEVENTHANDLER
