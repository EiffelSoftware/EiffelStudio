indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.ObjRef"

external class
	SYSTEM_RUNTIME_REMOTING_OBJREF

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_IOBJECTREFERENCE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (o: SYSTEM_MARSHALBYREFOBJECT; requested_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.MarshalByRefObject, System.Type) use System.Runtime.Remoting.ObjRef"
		end

	frozen make_1 is
		external
			"IL creator use System.Runtime.Remoting.ObjRef"
		end

feature -- Access

	get_channel_info: SYSTEM_RUNTIME_REMOTING_ICHANNELINFO is
		external
			"IL signature (): System.Runtime.Remoting.IChannelInfo use System.Runtime.Remoting.ObjRef"
		alias
			"get_ChannelInfo"
		end

	get_envoy_info: SYSTEM_RUNTIME_REMOTING_IENVOYINFO is
		external
			"IL signature (): System.Runtime.Remoting.IEnvoyInfo use System.Runtime.Remoting.ObjRef"
		alias
			"get_EnvoyInfo"
		end

	get_type_info: SYSTEM_RUNTIME_REMOTING_IREMOTINGTYPEINFO is
		external
			"IL signature (): System.Runtime.Remoting.IRemotingTypeInfo use System.Runtime.Remoting.ObjRef"
		alias
			"get_TypeInfo"
		end

	get_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ObjRef"
		alias
			"get_URI"
		end

feature -- Element Change

	set_channel_info (value: SYSTEM_RUNTIME_REMOTING_ICHANNELINFO) is
		external
			"IL signature (System.Runtime.Remoting.IChannelInfo): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_ChannelInfo"
		end

	set_envoy_info (value: SYSTEM_RUNTIME_REMOTING_IENVOYINFO) is
		external
			"IL signature (System.Runtime.Remoting.IEnvoyInfo): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_EnvoyInfo"
		end

	set_type_info (value: SYSTEM_RUNTIME_REMOTING_IREMOTINGTYPEINFO) is
		external
			"IL signature (System.Runtime.Remoting.IRemotingTypeInfo): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"set_TypeInfo"
		end

	set_uri (value: STRING) is
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

	get_real_object (context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT): ANY is
		external
			"IL signature (System.Runtime.Serialization.StreamingContext): System.Object use System.Runtime.Remoting.ObjRef"
		alias
			"GetRealObject"
		end

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.ObjRef"
		alias
			"GetObjectData"
		end

	to_string: STRING is
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

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_REMOTING_OBJREF
