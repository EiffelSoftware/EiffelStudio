indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.LogicalCallContext"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	LOGICAL_CALL_CONTEXT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE
	ICLONEABLE

create {NONE}

feature -- Access

	frozen get_has_info: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"get_HasInfo"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"ToString"
		end

	frozen free_named_data_slot (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"FreeNamedDataSlot"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"Clone"
		end

	frozen get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"GetObjectData"
		end

	frozen set_data (name: SYSTEM_STRING; data: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"SetData"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"Equals"
		end

	frozen get_data (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Runtime.Remoting.Messaging.LogicalCallContext"
		alias
			"GetData"
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

end -- class LOGICAL_CALL_CONTEXT
