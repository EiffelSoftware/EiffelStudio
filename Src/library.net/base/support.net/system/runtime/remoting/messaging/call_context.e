indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.CallContext"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CALL_CONTEXT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen set_data (name: SYSTEM_STRING; data: SYSTEM_OBJECT) is
		external
			"IL static signature (System.String, System.Object): System.Void use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"SetData"
		end

	frozen get_headers: NATIVE_ARRAY [HEADER] is
		external
			"IL static signature (): System.Runtime.Remoting.Messaging.Header[] use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"GetHeaders"
		end

	frozen free_named_data_slot (name: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"FreeNamedDataSlot"
		end

	frozen get_data (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"GetData"
		end

	frozen set_headers (headers: NATIVE_ARRAY [HEADER]) is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"SetHeaders"
		end

end -- class CALL_CONTEXT
