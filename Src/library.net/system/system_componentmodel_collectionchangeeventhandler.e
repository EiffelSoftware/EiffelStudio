indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.CollectionChangeEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER

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
	make_collectionchangeeventhandler

feature {NONE} -- Initialization

	frozen make_collectionchangeeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.CollectionChangeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.CollectionChangeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.CollectionChangeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CollectionChangeEventArgs): System.Void use System.ComponentModel.CollectionChangeEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER
