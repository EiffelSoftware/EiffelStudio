indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ResourcePool"

frozen external class
	SYSTEM_ENTERPRISESERVICES_RESOURCEPOOL

create
	make

feature {NONE} -- Initialization

	frozen make (cb: TRANSACTIONENDDELEGATE_IN_SYSTEM_ENTERPRISESERVICES_RESOURCEPOOL) is
		external
			"IL creator signature (System.EnterpriseServices.ResourcePool+TransactionEndDelegate) use System.EnterpriseServices.ResourcePool"
		end

feature -- Basic Operations

	frozen get_resource: ANY is
		external
			"IL signature (): System.Object use System.EnterpriseServices.ResourcePool"
		alias
			"GetResource"
		end

	frozen get_token: POINTER is
		external
			"IL signature (): System.IntPtr use System.EnterpriseServices.ResourcePool"
		alias
			"GetToken"
		end

	frozen put_resource (resource: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.ResourcePool"
		alias
			"PutResource"
		end

	frozen release_token is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ResourcePool"
		alias
			"ReleaseToken"
		end

end -- class SYSTEM_ENTERPRISESERVICES_RESOURCEPOOL
