indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.PropertyValueUIItemInvokeHandler"

frozen external class
	SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEMINVOKEHANDLER

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
	make_propertyvalueuiiteminvokehandler

feature {NONE} -- Initialization

	frozen make_propertyvalueuiiteminvokehandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		end

feature -- Basic Operations

	begin_invoke (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; descriptor: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; invoked_item: SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEM; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Drawing.Design.PropertyValueUIItem, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		alias
			"EndInvoke"
		end

	invoke (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; descriptor: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; invoked_item: SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEM) is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Drawing.Design.PropertyValueUIItem): System.Void use System.Drawing.Design.PropertyValueUIItemInvokeHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIITEMINVOKEHANDLER
