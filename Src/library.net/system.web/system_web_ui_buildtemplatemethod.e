indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.BuildTemplateMethod"

frozen external class
	SYSTEM_WEB_UI_BUILDTEMPLATEMETHOD

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
		rename
			equals as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			equals as equals_object
		end

create
	make_buildtemplatemethod

feature {NONE} -- Initialization

	frozen make_buildtemplatemethod (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.BuildTemplateMethod"
		end

feature -- Basic Operations

	begin_invoke (control: SYSTEM_WEB_UI_CONTROL; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Web.UI.Control, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.BuildTemplateMethod"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.BuildTemplateMethod"
		alias
			"EndInvoke"
		end

	invoke (control: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.BuildTemplateMethod"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_BUILDTEMPLATEMETHOD
