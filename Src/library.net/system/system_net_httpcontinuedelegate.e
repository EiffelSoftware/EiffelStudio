indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.HttpContinueDelegate"

frozen external class
	SYSTEM_NET_HTTPCONTINUEDELEGATE

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
	make_httpcontinuedelegate

feature {NONE} -- Initialization

	frozen make_httpcontinuedelegate (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Net.HttpContinueDelegate"
		end

feature -- Basic Operations

	begin_invoke (status_code: INTEGER; http_headers: SYSTEM_NET_WEBHEADERCOLLECTION; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Int32, System.Net.WebHeaderCollection, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.HttpContinueDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Net.HttpContinueDelegate"
		alias
			"EndInvoke"
		end

	invoke (status_code: INTEGER; http_headers: SYSTEM_NET_WEBHEADERCOLLECTION) is
		external
			"IL signature (System.Int32, System.Net.WebHeaderCollection): System.Void use System.Net.HttpContinueDelegate"
		alias
			"Invoke"
		end

end -- class SYSTEM_NET_HTTPCONTINUEDELEGATE
