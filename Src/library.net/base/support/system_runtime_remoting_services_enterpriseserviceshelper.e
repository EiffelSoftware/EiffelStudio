indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Services.EnterpriseServicesHelper"

frozen external class
	SYSTEM_RUNTIME_REMOTING_SERVICES_ENTERPRISESERVICESHELPER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		end

feature -- Basic Operations

	frozen wrap_iunknown_with_com_object (punk: POINTER): ANY is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		alias
			"WrapIUnknownWithComObject"
		end

	frozen create_construction_return_message (ctor_msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE; ret_obj: SYSTEM_MARSHALBYREFOBJECT): SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONRETURNMESSAGE is
		external
			"IL static signature (System.Runtime.Remoting.Activation.IConstructionCallMessage, System.MarshalByRefObject): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		alias
			"CreateConstructionReturnMessage"
		end

	frozen switch_wrappers (oldcp: SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY; newcp: SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY) is
		external
			"IL static signature (System.Runtime.Remoting.Proxies.RealProxy, System.Runtime.Remoting.Proxies.RealProxy): System.Void use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		alias
			"SwitchWrappers"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SERVICES_ENTERPRISESERVICESHELPER
