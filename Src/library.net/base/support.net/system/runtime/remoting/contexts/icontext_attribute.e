indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.IContextAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONTEXT_ATTRIBUTE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_properties_for_new_context (msg: ICONSTRUCTION_CALL_MESSAGE) is
		external
			"IL deferred signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Contexts.IContextAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	is_context_ok (ctx: CONTEXT; msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Contexts.IContextAttribute"
		alias
			"IsContextOK"
		end

end -- class ICONTEXT_ATTRIBUTE
