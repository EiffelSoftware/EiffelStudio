indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Handlers.TraceHandler"

external class
	SYSTEM_WEB_HANDLERS_TRACEHANDLER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_IHTTPHANDLER
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Handlers.TraceHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Handlers.TraceHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen show_details (data: SYSTEM_DATA_DATASET) is
		external
			"IL signature (System.Data.DataSet): System.Void use System.Web.Handlers.TraceHandler"
		alias
			"ShowDetails"
		end

	frozen system_web_ihttp_handler_process_request (context: SYSTEM_WEB_HTTPCONTEXT) is
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

	frozen show_requests (datasets: SYSTEM_COLLECTIONS_ARRAYLIST) is
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

end -- class SYSTEM_WEB_HANDLERS_TRACEHANDLER
