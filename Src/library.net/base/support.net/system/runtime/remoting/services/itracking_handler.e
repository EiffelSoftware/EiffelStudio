indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Services.ITrackingHandler"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ITRACKING_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	disconnected_object (obj: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.Remoting.Services.ITrackingHandler"
		alias
			"DisconnectedObject"
		end

	marshaled_object (obj: SYSTEM_OBJECT; or_: OBJ_REF) is
		external
			"IL deferred signature (System.Object, System.Runtime.Remoting.ObjRef): System.Void use System.Runtime.Remoting.Services.ITrackingHandler"
		alias
			"MarshaledObject"
		end

	unmarshaled_object (obj: SYSTEM_OBJECT; or_: OBJ_REF) is
		external
			"IL deferred signature (System.Object, System.Runtime.Remoting.ObjRef): System.Void use System.Runtime.Remoting.Services.ITrackingHandler"
		alias
			"UnmarshaledObject"
		end

end -- class ITRACKING_HANDLER
