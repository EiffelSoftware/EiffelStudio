indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.IMessageCtrl"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IMESSAGE_CTRL

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	cancel (ms_to_cancel: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.Remoting.Messaging.IMessageCtrl"
		alias
			"Cancel"
		end

end -- class IMESSAGE_CTRL
