indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.IContextProperty"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICONTEXT_PROPERTY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Contexts.IContextProperty"
		alias
			"get_Name"
		end

feature -- Basic Operations

	is_new_context_ok (new_ctx: CONTEXT): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.IContextProperty"
		alias
			"IsNewContextOK"
		end

	freeze (new_context: CONTEXT) is
		external
			"IL deferred signature (System.Runtime.Remoting.Contexts.Context): System.Void use System.Runtime.Remoting.Contexts.IContextProperty"
		alias
			"Freeze"
		end

end -- class ICONTEXT_PROPERTY
