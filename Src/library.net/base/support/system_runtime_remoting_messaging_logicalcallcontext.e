indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.LogicalCallContext"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_ICLONEABLE

create {NONE}

feature -- Access

	frozen get_has_info: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"get_HasInfo"
		end

feature -- Basic Operations

	frozen set_data (name: STRING; data: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"SetData"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"Equals"
		end

	frozen get_data (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"GetData"
		end

	frozen free_named_data_slot (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"FreeNamedDataSlot"
		end

	frozen get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"GetObjectData"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"Clone"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT
