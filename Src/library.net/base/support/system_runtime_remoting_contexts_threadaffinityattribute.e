indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"

external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_THREADAFFINITYATTRIBUTE

inherit
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXTATTRIBUTE
		redefine
			freeze,
			get_Properties_for_new_context,
			is_context_ok,
			finalize
		end
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTESERVERCONTEXTSINK
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTRIBUTECLIENTCONTEXTSINK

create
	make_thread_affinity_attribute_2,
	make_thread_affinity_attribute_3,
	make_thread_affinity_attribute,
	make_thread_affinity_attribute_1

feature {NONE} -- Initialization

	frozen make_thread_affinity_attribute_2 (flag: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		end

	frozen make_thread_affinity_attribute_3 (flag: INTEGER; bReEntrant: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		end

	frozen make_thread_affinity_attribute is
		external
			"IL creator use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		end

	frozen make_thread_affinity_attribute_1 (bReEntrant: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		end

feature -- Access

	frozen requires_new: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"REQUIRES_NEW"
		end

	frozen supported: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"SUPPORTED"
		end

	frozen not_supported: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"NOT_SUPPORTED"
		end

	frozen required: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"REQUIRED"
		end

feature -- Basic Operations

	get_properties_for_new_context (ctorMsg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	get_client_context_sink (nextSink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"GetClientContextSink"
		end

	is_context_ok (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT; msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"IsContextOK"
		end

	get_server_context_sink (nextSink: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK): SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGESINK is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessageSink): System.Runtime.Remoting.Messaging.IMessageSink use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"GetServerContextSink"
		end

	freeze (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context): System.Void use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"Freeze"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Contexts.ThreadAffinityAttribute"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_THREADAFFINITYATTRIBUTE
