indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ITransaction"

deferred external class
	SYSTEM_ENTERPRISESERVICES_ITRANSACTION

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	commit (f_retaining: INTEGER; grf_tc: INTEGER; grf_rm: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32): System.Void use System.EnterpriseServices.ITransaction"
		alias
			"Commit"
		end

	get_transaction_info (pinfo: SYSTEM_ENTERPRISESERVICES_XACTTRANSINFO) is
		external
			"IL deferred signature (System.EnterpriseServices.XACTTRANSINFO&): System.Void use System.EnterpriseServices.ITransaction"
		alias
			"GetTransactionInfo"
		end

	abort (pboid_reason: SYSTEM_ENTERPRISESERVICES_BOID; f_retaining: INTEGER; f_async: INTEGER) is
		external
			"IL deferred signature (System.EnterpriseServices.BOID&, System.Int32, System.Int32): System.Void use System.EnterpriseServices.ITransaction"
		alias
			"Abort"
		end

end -- class SYSTEM_ENTERPRISESERVICES_ITRANSACTION
