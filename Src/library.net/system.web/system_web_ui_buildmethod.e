indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.BuildMethod"

frozen external class
	SYSTEM_WEB_UI_BUILDMETHOD

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
	make_buildmethod

feature {NONE} -- Initialization

	frozen make_buildmethod (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.BuildMethod"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.BuildMethod"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): SYSTEM_WEB_UI_CONTROL is
		external
			"IL signature (System.IAsyncResult): System.Web.UI.Control use System.Web.UI.BuildMethod"
		alias
			"EndInvoke"
		end

	invoke: SYSTEM_WEB_UI_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.BuildMethod"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_BUILDMETHOD
