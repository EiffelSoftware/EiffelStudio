indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.IHttpAsyncHandler"

deferred external class
	SYSTEM_WEB_IHTTPASYNCHANDLER

inherit
	SYSTEM_WEB_IHTTPHANDLER

feature -- Basic Operations

	end_process_request (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL deferred signature (System.IAsyncResult): System.Void use System.Web.IHttpAsyncHandler"
		alias
			"EndProcessRequest"
		end

	begin_process_request (context: SYSTEM_WEB_HTTPCONTEXT; cb: SYSTEM_ASYNCCALLBACK; extra_data: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL deferred signature (System.Web.HttpContext, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.IHttpAsyncHandler"
		alias
			"BeginProcessRequest"
		end

end -- class SYSTEM_WEB_IHTTPASYNCHANDLER
