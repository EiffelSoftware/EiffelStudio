indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_TRANSACTION_END_DELEGATE_IN_ENT_SERV_RESOURCE_POOL

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_ent_serv_transaction_end_delegate_in_ent_serv_resource_pool

feature {NONE} -- Initialization

	frozen make_ent_serv_transaction_end_delegate_in_ent_serv_resource_pool (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		end

feature -- Basic Operations

	begin_invoke (resource: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		alias
			"EndInvoke"
		end

	invoke (resource: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		alias
			"Invoke"
		end

end -- class ENT_SERV_TRANSACTION_END_DELEGATE_IN_ENT_SERV_RESOURCE_POOL
