indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Proxies.RealProxy"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	REAL_PROXY

inherit
	SYSTEM_OBJECT

feature -- Basic Operations

	frozen get_stub_data (rp: REAL_PROXY): SYSTEM_OBJECT is
		external
			"IL static signature (System.Runtime.Remoting.Proxies.RealProxy): System.Object use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetStubData"
		end

	set_comiunknown (i: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SetCOMIUnknown"
		end

	get_transparent_proxy: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetTransparentProxy"
		end

	supports_interface (iid: GUID): POINTER is
		external
			"IL signature (System.Guid&): System.IntPtr use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SupportsInterface"
		end

	frozen get_proxied_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetProxiedType"
		end

	get_comiunknown (f_is_marshalled: BOOLEAN): POINTER is
		external
			"IL signature (System.Boolean): System.IntPtr use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetCOMIUnknown"
		end

	create_obj_ref (requested_type: TYPE): OBJ_REF is
		external
			"IL signature (System.Type): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"CreateObjRef"
		end

	frozen initialize_server_object (ctor_msg: ICONSTRUCTION_CALL_MESSAGE): ICONSTRUCTION_RETURN_MESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"InitializeServerObject"
		end

	invoke (msg: IMESSAGE): IMESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"Invoke"
		end

	frozen set_stub_data (rp: REAL_PROXY; stub_data: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Runtime.Remoting.Proxies.RealProxy, System.Object): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SetStubData"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetObjectData"
		end

feature {NONE} -- Implementation

	frozen detach_server: MARSHAL_BY_REF_OBJECT is
		external
			"IL signature (): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"DetachServer"
		end

	frozen attach_server (s: MARSHAL_BY_REF_OBJECT) is
		external
			"IL signature (System.MarshalByRefObject): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"AttachServer"
		end

	frozen get_unwrapped_server: MARSHAL_BY_REF_OBJECT is
		external
			"IL signature (): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetUnwrappedServer"
		end

end -- class REAL_PROXY
