indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ResourcePool+TransactionEndDelegate"

frozen external class
	TRANSACTIONENDDELEGATE_IN_SYSTEM_ENTERPRISESERVICES_RESOURCEPOOL

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
	make_transactionenddelegate

feature {NONE} -- Initialization

	frozen make_transactionenddelegate (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		end

feature -- Basic Operations

	begin_invoke (resource: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		alias
			"EndInvoke"
		end

	invoke (resource: ANY) is
		external
			"IL signature (System.Object): System.Void use System.EnterpriseServices.ResourcePool+TransactionEndDelegate"
		alias
			"Invoke"
		end

end -- class TRANSACTIONENDDELEGATE_IN_SYSTEM_ENTERPRISESERVICES_RESOURCEPOOL
