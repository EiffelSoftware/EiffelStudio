indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Activation.IConstructionCallMessage"

deferred external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE

inherit
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

feature -- Access

	get_activator: SYSTEM_RUNTIME_REMOTING_ACTIVATION_IACTIVATOR is
		external
			"IL deferred signature (): System.Runtime.Remoting.Activation.IActivator use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_Activator"
		end

	get_context_properties: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL deferred signature (): System.Collections.IList use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_ContextProperties"
		end

	get_activation_type_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_ActivationTypeName"
		end

	get_activation_Type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_ActivationType"
		end

	get_call_site_activation_attributes: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"get_CallSiteActivationAttributes"
		end

feature -- Element Change

	set_activator (value: SYSTEM_RUNTIME_REMOTING_ACTIVATION_IACTIVATOR) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IActivator): System.Void use System.Runtime.Remoting.Activation.IConstructionCallMessage"
		alias
			"set_Activator"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE
