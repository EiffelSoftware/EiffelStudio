indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.IRemoteDispatch"

deferred external class
	SYSTEM_ENTERPRISESERVICES_IREMOTEDISPATCH

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	remote_dispatch_not_auto_done (s: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.EnterpriseServices.IRemoteDispatch"
		alias
			"RemoteDispatchNotAutoDone"
		end

	remote_dispatch_auto_done (s: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.EnterpriseServices.IRemoteDispatch"
		alias
			"RemoteDispatchAutoDone"
		end

end -- class SYSTEM_ENTERPRISESERVICES_IREMOTEDISPATCH
