indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ITransaction"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ITRANSACTION

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	commit (f_retaining: INTEGER; grf_tc: INTEGER; grf_rm: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32): System.Void use System.EnterpriseServices.ITransaction"
		alias
			"Commit"
		end

	get_transaction_info (pinfo: ENT_SERV_XACTTRANSINFO) is
		external
			"IL deferred signature (System.EnterpriseServices.XACTTRANSINFO&): System.Void use System.EnterpriseServices.ITransaction"
		alias
			"GetTransactionInfo"
		end

	abort (pboid_reason: ENT_SERV_BOID; f_retaining: INTEGER; f_async: INTEGER) is
		external
			"IL deferred signature (System.EnterpriseServices.BOID&, System.Int32, System.Int32): System.Void use System.EnterpriseServices.ITransaction"
		alias
			"Abort"
		end

end -- class ENT_SERV_ITRANSACTION
