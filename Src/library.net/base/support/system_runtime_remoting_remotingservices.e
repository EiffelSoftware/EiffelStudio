indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.RemotingServices"

frozen external class
	SYSTEM_RUNTIME_REMOTING_REMOTINGSERVICES

create {NONE}

feature -- Basic Operations

	frozen marshal_marshal_by_ref_object_string_type (obj: SYSTEM_MARSHALBYREFOBJECT; obj_uri: STRING; requested_type: SYSTEM_TYPE): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL static signature (System.MarshalByRefObject, System.String, System.Type): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"Marshal"
		end

	frozen get_object_uri (obj: SYSTEM_MARSHALBYREFOBJECT): STRING is
		external
			"IL static signature (System.MarshalByRefObject): System.String use System.Runtime.Remoting.RemotingServices"
		alias
			"GetObjectUri"
		end

	frozen get_obj_ref_for_proxy (obj: SYSTEM_MARSHALBYREFOBJECT): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL static signature (System.MarshalByRefObject): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"GetObjRefForProxy"
		end

	frozen execute_message (target: SYSTEM_MARSHALBYREFOBJECT; req_msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODRETURNMESSAGE is
		external
			"IL static signature (System.MarshalByRefObject, System.Runtime.Remoting.Messaging.IMethodCallMessage): System.Runtime.Remoting.Messaging.IMethodReturnMessage use System.Runtime.Remoting.RemotingServices"
		alias
			"ExecuteMessage"
		end

	frozen get_server_type_for_uri (uri: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.String): System.Type use System.Runtime.Remoting.RemotingServices"
		alias
			"GetServerTypeForUri"
		end

	frozen set_object_uri_for_marshal (obj: SYSTEM_MARSHALBYREFOBJECT; uri: STRING) is
		external
			"IL static signature (System.MarshalByRefObject, System.String): System.Void use System.Runtime.Remoting.RemotingServices"
		alias
			"SetObjectUriForMarshal"
		end

	frozen get_object_data (obj: ANY; info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL static signature (System.Object, System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.RemotingServices"
		alias
			"GetObjectData"
		end

	frozen get_method_base_from_method_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE): SYSTEM_REFLECTION_METHODBASE is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMethodMessage): System.Reflection.MethodBase use System.Runtime.Remoting.RemotingServices"
		alias
			"GetMethodBaseFromMethodMessage"
		end

	frozen disconnect (obj: SYSTEM_MARSHALBYREFOBJECT): BOOLEAN is
		external
			"IL static signature (System.MarshalByRefObject): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"Disconnect"
		end

	frozen get_lifetime_service (obj: SYSTEM_MARSHALBYREFOBJECT): ANY is
		external
			"IL static signature (System.MarshalByRefObject): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"GetLifetimeService"
		end

	frozen get_real_proxy (proxy: ANY): SYSTEM_RUNTIME_REMOTING_PROXIES_REALPROXY is
		external
			"IL static signature (System.Object): System.Runtime.Remoting.Proxies.RealProxy use System.Runtime.Remoting.RemotingServices"
		alias
			"GetRealProxy"
		end

	frozen is_one_way (method: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		external
			"IL static signature (System.Reflection.MethodBase): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsOneWay"
		end

	frozen marshal_marshal_by_ref_object_string (obj: SYSTEM_MARSHALBYREFOBJECT; uri: STRING): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL static signature (System.MarshalByRefObject, System.String): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"Marshal"
		end

	frozen connect (class_to_proxy: SYSTEM_TYPE; url: STRING): ANY is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Connect"
		end

	frozen is_method_overloaded (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE): BOOLEAN is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMethodMessage): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsMethodOverloaded"
		end

	frozen is_object_out_of_app_domain (tp: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsObjectOutOfAppDomain"
		end

	frozen unmarshal_obj_ref_boolean (object_ref: SYSTEM_RUNTIME_REMOTING_OBJREF; f_refine: BOOLEAN): ANY is
		external
			"IL static signature (System.Runtime.Remoting.ObjRef, System.Boolean): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Unmarshal"
		end

	frozen get_envoy_chain_for_proxy (obj: SYSTEM_MARSHALBYREFOBJECT): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL static signature (System.MarshalByRefObject): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.RemotingServices"
		alias
			"GetEnvoyChainForProxy"
		end

	frozen unmarshal (object_ref: SYSTEM_RUNTIME_REMOTING_OBJREF): ANY is
		external
			"IL static signature (System.Runtime.Remoting.ObjRef): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Unmarshal"
		end

	frozen connect_type_string_object (class_to_proxy: SYSTEM_TYPE; url: STRING; data: ANY): ANY is
		external
			"IL static signature (System.Type, System.String, System.Object): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Connect"
		end

	frozen is_transparent_proxy (proxy: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsTransparentProxy"
		end

	frozen is_object_out_of_context (tp: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsObjectOutOfContext"
		end

	frozen get_session_id_for_method_message (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE): STRING is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMethodMessage): System.String use System.Runtime.Remoting.RemotingServices"
		alias
			"GetSessionIdForMethodMessage"
		end

	frozen marshal (obj: SYSTEM_MARSHALBYREFOBJECT): SYSTEM_RUNTIME_REMOTING_OBJREF is
		external
			"IL static signature (System.MarshalByRefObject): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"Marshal"
		end

	frozen log_remoting_stage (stage: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Runtime.Remoting.RemotingServices"
		alias
			"LogRemotingStage"
		end

end -- class SYSTEM_RUNTIME_REMOTING_REMOTINGSERVICES
