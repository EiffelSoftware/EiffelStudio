indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ServicedComponent"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_SERVICED_COMPONENT

inherit
	CONTEXT_BOUND_OBJECT
	ENT_SERV_IREMOTE_DISPATCH
		rename
			remote_dispatch_not_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done,
			remote_dispatch_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done
		end
	IDISPOSABLE
	ENT_SERV_ISERVICED_COMPONENT_INFO
		rename
			get_component_info as system_enterprise_services_iserviced_component_info_get_component_info
		end

feature -- Basic Operations

	frozen dispose is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Dispose"
		end

	frozen dispose_object (sc: ENT_SERV_SERVICED_COMPONENT) is
		external
			"IL static signature (System.EnterpriseServices.ServicedComponent): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"DisposeObject"
		end

feature {NONE} -- Implementation

	construct (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Construct"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Dispose"
		end

	frozen system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.EnterpriseServices.ServicedComponent"
		alias
			"System.EnterpriseServices.IRemoteDispatch.RemoteDispatchNotAutoDone"
		end

	can_be_pooled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ServicedComponent"
		alias
			"CanBePooled"
		end

	frozen system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.EnterpriseServices.ServicedComponent"
		alias
			"System.EnterpriseServices.IRemoteDispatch.RemoteDispatchAutoDone"
		end

	frozen system_enterprise_services_iserviced_component_info_get_component_info (info_mask: INTEGER; info_array: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.Int32&, System.String[]&): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"System.EnterpriseServices.IServicedComponentInfo.GetComponentInfo"
		end

	activate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Activate"
		end

	deactivate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Deactivate"
		end

end -- class ENT_SERV_SERVICED_COMPONENT
