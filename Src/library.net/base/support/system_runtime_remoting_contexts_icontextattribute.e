indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Contexts.IContextAttribute"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_properties_for_new_context (msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.IContextAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	is_context_ok (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT; msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.IContextAttribute"
		alias
			"IsContextOK"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE
