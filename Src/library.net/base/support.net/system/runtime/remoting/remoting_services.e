indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.RemotingServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REMOTING_SERVICES

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen marshal_marshal_by_ref_object_string_type (obj: MARSHAL_BY_REF_OBJECT; obj_uri: SYSTEM_STRING; requested_type: TYPE): OBJ_REF is
		external
			"IL static signature (System.MarshalByRefObject, System.String, System.Type): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"Marshal"
		end

	frozen get_object_uri (obj: MARSHAL_BY_REF_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.MarshalByRefObject): System.String use System.Runtime.Remoting.RemotingServices"
		alias
			"GetObjectUri"
		end

	frozen get_obj_ref_for_proxy (obj: MARSHAL_BY_REF_OBJECT): OBJ_REF is
		external
			"IL static signature (System.MarshalByRefObject): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"GetObjRefForProxy"
		end

	frozen execute_message (target: MARSHAL_BY_REF_OBJECT; req_msg: IMETHOD_CALL_MESSAGE): IMETHOD_RETURN_MESSAGE is
		external
			"IL static signature (System.MarshalByRefObject, System.Runtime.Remoting.Messaging.IMethodCallMessage): System.Runtime.Remoting.Messaging.IMethodReturnMessage use System.Runtime.Remoting.RemotingServices"
		alias
			"ExecuteMessage"
		end

	frozen get_server_type_for_uri (uri: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.String): System.Type use System.Runtime.Remoting.RemotingServices"
		alias
			"GetServerTypeForUri"
		end

	frozen set_object_uri_for_marshal (obj: MARSHAL_BY_REF_OBJECT; uri: SYSTEM_STRING) is
		external
			"IL static signature (System.MarshalByRefObject, System.String): System.Void use System.Runtime.Remoting.RemotingServices"
		alias
			"SetObjectUriForMarshal"
		end

	frozen get_object_data (obj: SYSTEM_OBJECT; info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL static signature (System.Object, System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.RemotingServices"
		alias
			"GetObjectData"
		end

	frozen get_method_base_from_method_message (msg: IMETHOD_MESSAGE): METHOD_BASE is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMethodMessage): System.Reflection.MethodBase use System.Runtime.Remoting.RemotingServices"
		alias
			"GetMethodBaseFromMethodMessage"
		end

	frozen disconnect (obj: MARSHAL_BY_REF_OBJECT): BOOLEAN is
		external
			"IL static signature (System.MarshalByRefObject): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"Disconnect"
		end

	frozen get_lifetime_service (obj: MARSHAL_BY_REF_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.MarshalByRefObject): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"GetLifetimeService"
		end

	frozen get_real_proxy (proxy: SYSTEM_OBJECT): REAL_PROXY is
		external
			"IL static signature (System.Object): System.Runtime.Remoting.Proxies.RealProxy use System.Runtime.Remoting.RemotingServices"
		alias
			"GetRealProxy"
		end

	frozen is_one_way (method: METHOD_BASE): BOOLEAN is
		external
			"IL static signature (System.Reflection.MethodBase): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsOneWay"
		end

	frozen marshal_marshal_by_ref_object_string (obj: MARSHAL_BY_REF_OBJECT; uri: SYSTEM_STRING): OBJ_REF is
		external
			"IL static signature (System.MarshalByRefObject, System.String): System.Runtime.Remoting.ObjRef use System.Runtime.Remoting.RemotingServices"
		alias
			"Marshal"
		end

	frozen connect (class_to_proxy: TYPE; url: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Connect"
		end

	frozen is_method_overloaded (msg: IMETHOD_MESSAGE): BOOLEAN is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMethodMessage): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsMethodOverloaded"
		end

	frozen is_object_out_of_app_domain (tp: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsObjectOutOfAppDomain"
		end

	frozen unmarshal_obj_ref_boolean (object_ref: OBJ_REF; f_refine: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL static signature (System.Runtime.Remoting.ObjRef, System.Boolean): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Unmarshal"
		end

	frozen get_envoy_chain_for_proxy (obj: MARSHAL_BY_REF_OBJECT): IMESSAGE_SINK is
		external
			"IL static signature (System.MarshalByRefObject): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.RemotingServices"
		alias
			"GetEnvoyChainForProxy"
		end

	frozen unmarshal (object_ref: OBJ_REF): SYSTEM_OBJECT is
		external
			"IL static signature (System.Runtime.Remoting.ObjRef): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Unmarshal"
		end

	frozen connect_type_string_object (class_to_proxy: TYPE; url: SYSTEM_STRING; data: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String, System.Object): System.Object use System.Runtime.Remoting.RemotingServices"
		alias
			"Connect"
		end

	frozen is_transparent_proxy (proxy: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsTransparentProxy"
		end

	frozen is_object_out_of_context (tp: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.Remoting.RemotingServices"
		alias
			"IsObjectOutOfContext"
		end

	frozen get_session_id_for_method_message (msg: IMETHOD_MESSAGE): SYSTEM_STRING is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.IMethodMessage): System.String use System.Runtime.Remoting.RemotingServices"
		alias
			"GetSessionIdForMethodMessage"
		end

	frozen marshal (obj: MARSHAL_BY_REF_OBJECT): OBJ_REF is
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

end -- class REMOTING_SERVICES
