indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpWorkerRequest+EndOfSendNotification"

frozen external class
	ENDOFSENDNOTIFICATION_IN_SYSTEM_WEB_HTTPWORKERREQUEST

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
	make_endofsendnotification

feature {NONE} -- Initialization

	frozen make_endofsendnotification (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.HttpWorkerRequest+EndOfSendNotification"
		end

feature -- Basic Operations

	begin_invoke (wr: SYSTEM_WEB_HTTPWORKERREQUEST; extra_data: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Web.HttpWorkerRequest, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.HttpWorkerRequest+EndOfSendNotification"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.HttpWorkerRequest+EndOfSendNotification"
		alias
			"EndInvoke"
		end

	invoke (wr: SYSTEM_WEB_HTTPWORKERREQUEST; extra_data: ANY) is
		external
			"IL signature (System.Web.HttpWorkerRequest, System.Object): System.Void use System.Web.HttpWorkerRequest+EndOfSendNotification"
		alias
			"Invoke"
		end

end -- class ENDOFSENDNOTIFICATION_IN_SYSTEM_WEB_HTTPWORKERREQUEST
