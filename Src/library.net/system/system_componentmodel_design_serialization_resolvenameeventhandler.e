indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.ResolveNameEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTHANDLER

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
	make_resolvenameeventhandler

feature {NONE} -- Initialization

	frozen make_resolvenameeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.Design.Serialization.ResolveNameEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.Design.Serialization.ResolveNameEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.Serialization.ResolveNameEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.Design.Serialization.ResolveNameEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.Design.Serialization.ResolveNameEventArgs): System.Void use System.ComponentModel.Design.Serialization.ResolveNameEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTHANDLER
