indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.RefreshEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_REFRESHEVENTHANDLER

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
	make_refresheventhandler

feature {NONE} -- Initialization

	frozen make_refresheventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.RefreshEventHandler"
		end

feature -- Basic Operations

	begin_invoke (e: SYSTEM_COMPONENTMODEL_REFRESHEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.ComponentModel.RefreshEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.RefreshEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.RefreshEventHandler"
		alias
			"EndInvoke"
		end

	invoke (e: SYSTEM_COMPONENTMODEL_REFRESHEVENTARGS) is
		external
			"IL signature (System.ComponentModel.RefreshEventArgs): System.Void use System.ComponentModel.RefreshEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_REFRESHEVENTHANDLER
