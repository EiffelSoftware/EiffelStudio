indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Proxies.RealProxy"

deferred external class
	SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY

feature -- Basic Operations

	supports_interface (iid: SYSTEM_GUID): POINTER is
		external
			"IL signature (System.Guid&): System.IntPtr use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SupportsInterface"
		end

	invoke (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE is
		external
			"IL deferred signature (System.Runtime.Remoting.Messaging.IMessage): System.Runtime.Remoting.Messaging.IMessage use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"Invoke"
		end

	frozen propagate_out_parameters (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; outArgs: ARRAY [ANY]; returnValue: ANY) is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMessage, System.Object[], System.Object): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"PropagateOutParameters"
		end

	frozen get_proxied_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetProxiedType"
		end

	frozen set_stub_data (rp: SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY; stubData: ANY) is
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

	create_obj_ref (requestedType: SYSTEM_TYPE): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL signature (System.Type): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"CreateObjRef"
		end

	frozen get_stub_data (rp: SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY): ANY is
		external
			"IL static signature (System.Runtime.Remoting.Proxies.RealProxy): System.Object use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetStubData"
		end

	get_transparent_proxy: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetTransparentProxy"
		end

	frozen initialize_server_object (ctorMsg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONRETURNMESSAGE is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Runtime.Remoting.Activation.IConstructionReturnMessage use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"InitializeServerObject"
		end

	frozen handle_return_message (reqMsg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; retMsg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE) is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Messaging.IMessage): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"HandleReturnMessage"
		end

	set_com_i_unknown (i: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"SetCOMIUnknown"
		end

	get_com_i_unknown (fIsMarshalled: BOOLEAN): POINTER is
		external
			"IL signature (System.Boolean): System.IntPtr use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetCOMIUnknown"
		end

feature {NONE} -- Implementation

	frozen get_unwrapped_server: SYSTEM_MARSHALBYREFOBJECT is
		external
			"IL signature (): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"GetUnwrappedServer"
		end

	frozen detach_server: SYSTEM_MARSHALBYREFOBJECT is
		external
			"IL signature (): System.MarshalByRefObject use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"DetachServer"
		end

	frozen propagate_server (server: SYSTEM_MARSHALBYREFOBJECT) is
		external
			"IL signature (System.MarshalByRefObject): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"PropagateServer"
		end

	frozen attach_server (s: SYSTEM_MARSHALBYREFOBJECT) is
		external
			"IL signature (System.MarshalByRefObject): System.Void use System.Runtime.Remoting.Proxies.RealProxy"
		alias
			"AttachServer"
		end

end -- class SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY
