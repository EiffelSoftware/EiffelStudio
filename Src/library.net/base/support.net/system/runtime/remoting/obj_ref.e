indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.ObjRef"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	OBJ_REF

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IOBJECT_REFERENCE
	ISERIALIZABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (o: MARSHAL_BY_REF_OBJECT; requested_type: TYPE) is
		external
			"IL creator signature (System.MarshalByRefObject, System.Type) use System.Runtime.Remoting.ObjRef"
		end

	frozen make_1 is
		external
			"IL creator use System.Runtime.Remoting.ObjRef"
		end

feature -- Access

	get_channel_info: ICHANNEL_INFO is
		external
			"IL signature (): System.Runtime.Remoting.IChannelInfo use System.Runtime.Remoting.ObjRef"
		alias
			"get_ChannelInfo"
		end

	get_envoy_info: IENVOY_INFO is
		external
			"IL signature (): System.Runtime.Remoting.IEnvoyInfo use System.Runtime.Remoting.ObjRef"
		alias
			"get_EnvoyInfo"
		end

	get_type_info: IREMOTING_TYPE_INFO is
		external
			"IL signature (): System.Runtime.Remoting.IRemotingTypeInfo use System.Runtime.Remoting.ObjRef"
		alias
			"get_TypeInfo"
		end

	get_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ObjRef"
		alias
			"get_URI"
		end

feature -- Element Change

	set_channel_info (value: ICHANNEL_INFO) is
		external
			"IL signature (System.Runtime.Remoting.IChannelInfo): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_ChannelInfo"
		end

	set_envoy_info (value: IENVOY_INFO) is
		external
			"IL signature (System.Runtime.Remoting.IEnvoyInfo): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_EnvoyInfo"
		end

	set_type_info (value: IREMOTING_TYPE_INFO) is
		external
			"IL signature (System.Runtime.Remoting.IRemotingTypeInfo): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_TypeInfo"
		end

	set_uri (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_URI"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.ObjRef"
		alias
			"GetHashCode"
		end

	frozen is_from_this_app_domain: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.ObjRef"
		alias
			"IsFromThisAppDomain"
		end

	get_real_object (context: STREAMING_CONTEXT): SYSTEM_OBJECT is
		external
			"IL signature (System.Runtime.Serialization.StreamingContext): System.Object use System.Runtime.Remoting.ObjRef"
		alias
			"GetRealObject"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ObjRef"
		alias
			"ToString"
		end

	frozen is_from_this_process: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.ObjRef"
		alias
			"IsFromThisProcess"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.ObjRef"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"Finalize"
		end

end -- class OBJ_REF
