indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ComponentRenameEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTHANDLER

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
	make_componentrenameeventhandler

feature {NONE} -- Initialization

	frozen make_componentrenameeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.Design.ComponentRenameEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.Design.ComponentRenameEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.ComponentRenameEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.Design.ComponentRenameEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.Design.ComponentRenameEventArgs): System.Void use System.ComponentModel.Design.ComponentRenameEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTHANDLER
