indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Activation.IConstructionCallMessage"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONSTRUCTION_CALL_MESSAGE

inherit
	IMETHOD_CALL_MESSAGE
	IMETHOD_MESSAGE
	IMESSAGE

feature -- Access

	get_context_properties: ILIST is
		external
			"IL deferred signature (): System.Collections.IList use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_ContextProperties"
		end

	get_call_site_activation_attributes: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_CallSiteActivationAttributes"
		end

	get_activator: IACTIVATOR is
		external
			"IL deferred signature (): System.Runtime.Remoting.Activation.IActivator use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_Activator"
		end

	get_activation_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_ActivationType"
		end

	get_activation_type_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_ActivationTypeName"
		end

feature -- Element Change

	set_activator (value: IACTIVATOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IActivator): System.Void use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"set_Activator"
		end

end -- class ICONSTRUCTION_CALL_MESSAGE
