indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.InternalMessageWrapper"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	INTERNAL_MESSAGE_WRAPPER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (msg: IMESSAGE) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMessage) use System.Runtime.Remoting.Messaging.InternalMessageWrapper"
		end

end -- class INTERNAL_MESSAGE_WRAPPER
