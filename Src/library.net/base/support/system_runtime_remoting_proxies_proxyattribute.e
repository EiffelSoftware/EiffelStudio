indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Proxies.ProxyAttribute"

external class
	SYSTEM_RUNTIME_REMOTING_PROXIES_PROXYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE

create
	make_proxyattribute

feature {NONE} -- Initialization

	frozen make_proxyattribute is
		external
			"IL creator use System.Runtime.Remoting.Proxies.ProxyAttribute"
		end

feature -- Basic Operations

	create_proxy (obj_ref: SYSTEM_RUNTIME_REMOTING_OBJREF; server_type: SYSTEM_TYPE; server_object: ANY; server_context: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT): SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY is
		external
			"IL signature (System.Runtime.Remoting.ObjRef, System.Type, System.Object, System.Runtime.Remoting.Contexts.Context): System.Runtime.Remoting.Proxies.RealProxy use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"CreateProxy"
		end

	frozen get_properties_for_new_context (msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	create_instance (server_type: SYSTEM_TYPE): SYSTEM_MARSHALBYREFOBJECT is
		external
			"IL signature (System.Type): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"CreateInstance"
		end

	frozen is_context_ok (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT; msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"IsContextOK"
		end

end -- class SYSTEM_RUNTIME_REMOTING_PROXIES_PROXYATTRIBUTE
