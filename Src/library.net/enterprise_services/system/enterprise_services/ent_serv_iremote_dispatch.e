indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.IRemoteDispatch"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_IREMOTE_DISPATCH

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	remote_dispatch_not_auto_done (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.EnterpriseServices.IRemoteDispatch"
		alias
			"RemoteDispatchNotAutoDone"
		end

	remote_dispatch_auto_done (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.EnterpriseServices.IRemoteDispatch"
		alias
			"RemoteDispatchAutoDone"
		end

end -- class ENT_SERV_IREMOTE_DISPATCH
