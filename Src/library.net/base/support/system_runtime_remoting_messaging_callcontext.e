indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.CallContext"

frozen external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_CALLCONTEXT

create {NONE}

feature -- Basic Operations

	frozen set_data (name: STRING; data: ANY) is
		external
			"IL static signature (System.String, System.Object): System.Void use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"SetData"
		end

	frozen get_headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER] is
		external
			"IL static signature (): System.Runtime.Remoting.Messaging.Header[] use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"GetHeaders"
		end

	frozen free_named_data_slot (name: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"FreeNamedDataSlot"
		end

	frozen get_data (name: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"GetData"
		end

	frozen set_headers (headers: ARRAY [SYSTEM_RUNTIME_REMOTING_MESSAGING_HEADER]) is
		external
			"IL static signature (System.Runtime.Remoting.Messaging.Header[]): System.Void use System.Runtime.Remoting.Messaging.CallContext"
		alias
			"SetHeaders"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_CALLCONTEXT
