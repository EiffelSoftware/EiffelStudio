indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.IContextPropertyActivator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONTEXT_PROPERTY_ACTIVATOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	collect_from_client_context (msg: ICONSTRUCTION_CALL_MESSAGE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.IContextPropertyActivator"
		alias
			"CollectFromClientContext"
		end

	collect_from_server_context (msg: ICONSTRUCTION_RETURN_MESSAGE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionReturnMessage): System.Void use System.Runtime.Remoting.Contexts.IContextPropertyActivator"
		alias
			"CollectFromServerContext"
		end

	deliver_client_context_to_server_context (msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.IContextPropertyActivator"
		alias
			"DeliverClientContextToServerContext"
		end

	deliver_server_context_to_client_context (msg: ICONSTRUCTION_RETURN_MESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionReturnMessage): System.Boolean use System.Runtime.Remoting.Contexts.IContextPropertyActivator"
		alias
			"DeliverServerContextToClientContext"
		end

	is_okto_activate (msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.IContextPropertyActivator"
		alias
			"IsOKToActivate"
		end

end -- class ICONTEXT_PROPERTY_ACTIVATOR
