indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpWorkerRequest+EndOfSendNotification"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_END_OF_SEND_NOTIFICATION_IN_WEB_HTTP_WORKER_REQUEST

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_end_of_send_notification_in_web_http_worker_request

feature {NONE} -- Initialization

	frozen make_web_end_of_send_notification_in_web_http_worker_request (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.HttpWorkerRequest+EndOfSendNotification"
		end

feature -- Basic Operations

	begin_invoke (wr: WEB_HTTP_WORKER_REQUEST; extra_data: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Web.HttpWorkerRequest, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.HttpWorkerRequest+EndOfSendNotification"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.HttpWorkerRequest+EndOfSendNotification"
		alias
			"EndInvoke"
		end

	invoke (wr: WEB_HTTP_WORKER_REQUEST; extra_data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Web.HttpWorkerRequest, System.Object): System.Void use System.Web.HttpWorkerRequest+EndOfSendNotification"
		alias
			"Invoke"
		end

end -- class WEB_END_OF_SEND_NOTIFICATION_IN_WEB_HTTP_WORKER_REQUEST
