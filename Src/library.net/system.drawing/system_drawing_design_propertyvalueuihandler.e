indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.PropertyValueUIHandler"

frozen external class
	SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIHANDLER

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
	make_propertyvalueuihandler

feature {NONE} -- Initialization

	frozen make_propertyvalueuihandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Design.PropertyValueUIHandler"
		end

feature -- Basic Operations

	begin_invoke (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; prop_desc: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; value_uiitem_list: SYSTEM_COLLECTIONS_ARRAYLIST; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Collections.ArrayList, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Design.PropertyValueUIHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Design.PropertyValueUIHandler"
		alias
			"EndInvoke"
		end

	invoke (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; prop_desc: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR; value_uiitem_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.ComponentModel.PropertyDescriptor, System.Collections.ArrayList): System.Void use System.Drawing.Design.PropertyValueUIHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_DESIGN_PROPERTYVALUEUIHANDLER
