indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Handlers.TraceHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TRACE_HANDLER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_IHTTP_HANDLER
		rename
			get_is_reusable as system_web_ihttp_handler_get_is_reusable,
			process_request as system_web_ihttp_handler_process_request
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Handlers.TraceHandler"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Handlers.TraceHandler"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Handlers.TraceHandler"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Handlers.TraceHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen show_details (data: DATA_DATA_SET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Web.Handlers.TraceHandler"
		alias
			"ShowDetails"
		end

	frozen system_web_ihttp_handler_process_request (context: WEB_HTTP_CONTEXT) is
		external
			"IL signature (System.Web.HttpContext): System.Void use System.Web.Handlers.TraceHandler"
		alias
			"System.Web.IHttpHandler.ProcessRequest"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.Handlers.TraceHandler"
		alias
			"Finalize"
		end

	frozen show_requests (datasets: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Web.Handlers.TraceHandler"
		alias
			"ShowRequests"
		end

	frozen system_web_ihttp_handler_get_is_reusable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Handlers.TraceHandler"
		alias
			"System.Web.IHttpHandler.get_IsReusable"
		end

end -- class WEB_TRACE_HANDLER
