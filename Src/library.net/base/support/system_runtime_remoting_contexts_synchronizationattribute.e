indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Contexts.SynchronizationAttribute"

external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_SYNCHRONIZATIONATTRIBUTE

inherit
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXTATTRIBUTE
		redefine
			get_properties_for_new_context,
			is_context_ok
		end
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTESERVERCONTEXTSINK
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTECLIENTCONTEXTSINK

create
	make_synchronizationattribute_2,
	make_synchronizationattribute_3,
	make_synchronizationattribute,
	make_synchronizationattribute_1

feature {NONE} -- Initialization

	frozen make_synchronizationattribute_2 (flag: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

	frozen make_synchronizationattribute_3 (flag: INTEGER; re_entrant: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

	frozen make_synchronizationattribute is
		external
			"IL creator use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		end

	frozen make_synchronizationattribute_1 (re_entrant: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
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

	get_client_context_sink (next_sink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"GetClientContextSink"
		end

	get_properties_for_new_context (ctor_msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	get_server_context_sink (next_sink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"GetServerContextSink"
		end

	is_context_ok (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT; msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.SynchronizationAttribute"
		alias
			"IsContextOK"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_SYNCHRONIZATIONATTRIBUTE
