indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Util.WorkItemCallback"

frozen external class
	SYSTEM_WEB_UTIL_WORKITEMCALLBACK

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_workitemcallback

feature {NONE} -- Initialization

	frozen make_workitemcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.Util.WorkItemCallback"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Util.WorkItemCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Util.WorkItemCallback"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Web.Util.WorkItemCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UTIL_WORKITEMCALLBACK
