indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Proxies.ProxyAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PROXY_ATTRIBUTE

inherit
	ATTRIBUTE
	ICONTEXT_ATTRIBUTE

create
	make_proxy_attribute

feature {NONE} -- Initialization

	frozen make_proxy_attribute is
		external
			"IL creator use System.Runtime.Remoting.Proxies.ProxyAttribute"
		end

feature -- Basic Operations

	create_proxy (obj_ref: OBJ_REF; server_type: TYPE; server_object: SYSTEM_OBJECT; server_context: CONTEXT): REAL_PROXY is
		external
			"IL signature (System.Runtime.Remoting.ObjRef, System.Type, System.Object, System.Runtime.Remoting.Contexts.Context): System.Runtime.Remoting.Proxies.RealProxy use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"CreateProxy"
		end

	frozen get_properties_for_new_context (msg: ICONSTRUCTION_CALL_MESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	create_instance (server_type: TYPE): MARSHAL_BY_REF_OBJECT is
		external
			"IL signature (System.Type): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"CreateInstance"
		end

	frozen is_context_ok (ctx: CONTEXT; msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Proxies.ProxyAttribute"
		alias
			"IsContextOK"
		end

end -- class PROXY_ATTRIBUTE
