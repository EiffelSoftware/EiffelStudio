indexing
	Generator: "Eiffel Emitter 2.5b2"
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

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_CALLCONTEXT
