indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ResourcePool"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_RESOURCE_POOL

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (cb: ENT_SERV_TRANSACTION_END_DELEGATE_IN_ENT_SERV_RESOURCE_POOL) is
		external
			"IL creator signature (System.EnterpriseServices.ResourcePool+TransactionEndDelegate) use System.EnterpriseServices.ResourcePool"
		end

feature -- Basic Operations

	frozen get_resource: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.EnterpriseServices.ResourcePool"
		alias
			"GetResource"
		end

	frozen put_resource (resource: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.ResourcePool"
		alias
			"PutResource"
		end

end -- class ENT_SERV_RESOURCE_POOL
