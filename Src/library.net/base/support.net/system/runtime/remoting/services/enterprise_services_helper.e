indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Services.EnterpriseServicesHelper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ENTERPRISE_SERVICES_HELPER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		end

feature -- Basic Operations

	frozen wrap_iunknown_with_com_object (punk: POINTER): SYSTEM_OBJECT is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		alias
			"WrapIUnknownWithComObject"
		end

	frozen create_construction_return_message (ctor_msg: ICONSTRUCTION_CALL_MESSAGE; ret_obj: MARSHAL_BY_REF_OBJECT): ICONSTRUCTION_RETURN_MESSAGE is
		external
			"IL static signature (System.Runtime.Remoting.Activation.IConstructionCallMessage, System.MarshalByRefObject): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		alias
			"CreateConstructionReturnMessage"
		end

	frozen switch_wrappers (oldcp: REAL_PROXY; newcp: REAL_PROXY) is
		external
			"IL static signature (System.Runtime.Remoting.Proxies.RealProxy, System.Runtime.Remoting.Proxies.RealProxy): System.Void use System.Runtime.Remoting.Services.EnterpriseServicesHelper"
		alias
			"SwitchWrappers"
		end

end -- class ENTERPRISE_SERVICES_HELPER
