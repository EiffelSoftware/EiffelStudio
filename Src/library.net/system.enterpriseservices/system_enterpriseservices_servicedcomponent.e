indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.ServicedComponent"

deferred external class
	SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENT

inherit
	SYSTEM_ENTERPRISESERVICES_IREMOTEDISPATCH
		rename
			remote_dispatch_not_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done,
			remote_dispatch_auto_done as system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_CONTEXTBOUNDOBJECT
		redefine
			finalize
		end

feature -- Basic Operations

	activate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Activate"
		end

	can_be_pooled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ServicedComponent"
		alias
			"CanBePooled"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Dispose"
		end

	deactivate is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Deactivate"
		end

	construct (s: STRING) is
		external
			"IL signature (System.String): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Construct"
		end

	frozen dispose_object (sc: SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENT) is
		external
			"IL static signature (System.EnterpriseServices.ServicedComponent): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"DisposeObject"
		end

feature {NONE} -- Implementation

	frozen system_enterprise_services_iremote_dispatch_remote_dispatch_auto_done (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.EnterpriseServices.ServicedComponent"
		alias
			"System.EnterpriseServices.IRemoteDispatch.RemoteDispatchAutoDone"
		end

	frozen system_enterprise_services_iremote_dispatch_remote_dispatch_not_auto_done (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.EnterpriseServices.ServicedComponent"
		alias
			"System.EnterpriseServices.IRemoteDispatch.RemoteDispatchNotAutoDone"
		end

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.ServicedComponent"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SERVICEDCOMPONENT
