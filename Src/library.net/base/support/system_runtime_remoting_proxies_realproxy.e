indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Proxies.RealProxy"

deferred external class
	SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY

feature -- Basic Operations

	frozen get_stub_data (rp: SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY): ANY is
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

	get_transparent_proxy: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetTransparentProxy"
		end

	supports_interface (iid: SYSTEM_GUID): POINTER is
		external
			"IL signature (System.Guid&): System.IntPtr use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SupportsInterface"
		end

	frozen get_proxied_type: SYSTEM_TYPE is
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

	create_obj_ref (requested_type: SYSTEM_TYPE): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL signature (System.Type): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"CreateObjRef"
		end

	frozen initialize_server_object (ctor_msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONRETURNMESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"InitializeServerObject"
		end

	invoke (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"Invoke"
		end

	frozen set_stub_data (rp: SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY; stub_data: ANY) is
		external
			"IL static signature (System.Runtime.Remoting.Proxies.RealProxy, System.Object): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SetStubData"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetObjectData"
		end

feature {NONE} -- Implementation

	frozen detach_server: SYSTEM_MARSHALBYREFOBJECT is
		external
			"IL signature (): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"DetachServer"
		end

	frozen attach_server (s: SYSTEM_MARSHALBYREFOBJECT) is
		external
			"IL signature (System.MarshalByRefObject): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"AttachServer"
		end

	frozen get_unwrapped_server: SYSTEM_MARSHALBYREFOBJECT is
		external
			"IL signature (): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetUnwrappedServer"
		end

end -- class SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY
