indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCacheValidateHandler"

frozen external class
	SYSTEM_WEB_HTTPCACHEVALIDATEHANDLER

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
	make_httpcachevalidatehandler

feature {NONE} -- Initialization

	frozen make_httpcachevalidatehandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.HttpCacheValidateHandler"
		end

feature -- Basic Operations

	begin_invoke (context: SYSTEM_WEB_HTTPCONTEXT; data: ANY; validation_status: SYSTEM_WEB_HTTPVALIDATIONSTATUS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Web.HttpContext, System.Object, System.Web.HttpValidationStatus&, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.HttpCacheValidateHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (validation_status: SYSTEM_WEB_HTTPVALIDATIONSTATUS; result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.Web.HttpValidationStatus&, System.IAsyncResult): System.Void use System.Web.HttpCacheValidateHandler"
		alias
			"EndInvoke"
		end

	invoke (context: SYSTEM_WEB_HTTPCONTEXT; data: ANY; validation_status: SYSTEM_WEB_HTTPVALIDATIONSTATUS) is
		external
			"IL signature (System.Web.HttpContext, System.Object, System.Web.HttpValidationStatus&): System.Void use System.Web.HttpCacheValidateHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_HTTPCACHEVALIDATEHANDLER
