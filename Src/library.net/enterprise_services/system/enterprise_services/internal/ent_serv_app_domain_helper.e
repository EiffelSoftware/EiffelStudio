indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.AppDomainHelper"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_APP_DOMAIN_HELPER

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.AppDomainHelper"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.AppDomainHelper"
		alias
			"Finalize"
		end

end -- class ENT_SERV_APP_DOMAIN_HELPER
