indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.IMessageCtrl"

deferred external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	cancel (msToCancel: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.Remoting.Messaging.IMessageCtrl"
		alias
			"Cancel"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGECTRL
