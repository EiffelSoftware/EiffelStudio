indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Contexts.ContextAttribute"

external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			is_equal
		end
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY

create
	make_context_attribute

feature {NONE} -- Initialization

	frozen make_context_attribute (name2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Contexts.ContextAttribute"
		end

feature -- Access

	get_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_properties_for_new_context (ctorMsg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"GetHashCode"
		end

	is_new_context_oK (newCtx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"IsNewContextOK"
		end

	is_context_ok (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT; ctorMsg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"IsContextOK"
		end

	freeze (newContext: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context): System.Void use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"Freeze"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXTATTRIBUTE
