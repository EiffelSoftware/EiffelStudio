indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ServiceCreatorCallback"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERVICECREATORCALLBACK

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
	make_servicecreatorcallback

feature {NONE} -- Initialization

	frozen make_servicecreatorcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.Design.ServiceCreatorCallback"
		end

feature -- Basic Operations

	begin_invoke (container: SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER; service_type: SYSTEM_TYPE; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.ComponentModel.Design.IServiceContainer, System.Type, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.ServiceCreatorCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): ANY is
		external
			"IL signature (System.IAsyncResult): System.Object use System.ComponentModel.Design.ServiceCreatorCallback"
		alias
			"EndInvoke"
		end

	invoke (container: SYSTEM_COMPONENTMODEL_DESIGN_ISERVICECONTAINER; service_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.Design.IServiceContainer, System.Type): System.Object use System.ComponentModel.Design.ServiceCreatorCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERVICECREATORCALLBACK
