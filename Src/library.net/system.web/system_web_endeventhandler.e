indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.EndEventHandler"

frozen external class
	SYSTEM_WEB_ENDEVENTHANDLER

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
	make_endeventhandler

feature {NONE} -- Initialization

	frozen make_endeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.EndEventHandler"
		end

feature -- Basic Operations

	begin_invoke (ar: SYSTEM_IASYNCRESULT; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.IAsyncResult, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.EndEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.EndEventHandler"
		alias
			"EndInvoke"
		end

	invoke (ar: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.EndEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_ENDEVENTHANDLER
