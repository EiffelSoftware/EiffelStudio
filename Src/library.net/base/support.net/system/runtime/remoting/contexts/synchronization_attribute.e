indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.SynchronizationAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYNCHRONIZATION_ATTRIBUTE

inherit
	CONTEXT_ATTRIBUTE
		redefine
			get_properties_for_new_context,
			is_context_ok
		end
	ICONTEXT_ATTRIBUTE
	ICONTEXT_PROPERTY
	ICONTRIBUTE_SERVER_CONTEXT_SINK
	ICONTRIBUTE_CLIENT_CONTEXT_SINK

create
	make_synchronization_attribute_2,
	make_synchronization_attribute,
	make_synchronization_attribute_1,
	make_synchronization_attribute_3

feature {NONE} -- Initialization

	frozen make_synchronization_attribute_2 (flag: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

	frozen make_synchronization_attribute is
		external
			"IL creator use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

	frozen make_synchronization_attribute_1 (re_entrant: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

	frozen make_synchronization_attribute_3 (flag: INTEGER; re_entrant: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

feature -- Access

	frozen supported: INTEGER is 0x2

	get_locked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"get_Locked"
		end

	frozen required: INTEGER is 0x4

	frozen requires_new: INTEGER is 0x8

	frozen not_supported: INTEGER is 0x1

	get_is_re_entrant: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"get_IsReEntrant"
		end

feature -- Element Change

	set_locked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"set_Locked"
		end

feature -- Basic Operations

	get_client_context_sink (next_sink: IMESSAGE_SINK): IMESSAGE_SINK is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"GetClientContextSink"
		end

	get_properties_for_new_context (ctor_msg: ICONSTRUCTION_CALL_MESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	get_server_context_sink (next_sink: IMESSAGE_SINK): IMESSAGE_SINK is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"GetServerContextSink"
		end

	is_context_ok (ctx: CONTEXT; msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"IsContextOK"
		end

end -- class SYNCHRONIZATION_ATTRIBUTE
