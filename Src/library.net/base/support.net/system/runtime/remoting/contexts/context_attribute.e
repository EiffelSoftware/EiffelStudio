indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.ContextAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CONTEXT_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end
	ICONTEXT_ATTRIBUTE
	ICONTEXT_PROPERTY

create
	make_context_attribute

feature {NONE} -- Initialization

	frozen make_context_attribute (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Contexts.ContextAttribute"
		end

feature -- Access

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"GetHashCode"
		end

	is_context_ok (ctx: CONTEXT; ctor_msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"IsContextOK"
		end

	get_properties_for_new_context (ctor_msg: ICONSTRUCTION_CALL_MESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	is_new_context_ok (new_ctx: CONTEXT): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"IsNewContextOK"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"Equals"
		end

	freeze (new_context: CONTEXT) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context): System.Void use System.Runtime.Remoting.Contexts.ContextAttribute"
		alias
			"Freeze"
		end

end -- class CONTEXT_ATTRIBUTE
