indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Contexts.IContextProperty"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Contexts.IContextProperty"
		alias
			"get_Name"
		end

feature -- Basic Operations

	is_new_context_ok (new_ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT): BOOLEAN is
		external
			"IL deferred signature (System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.IContextProperty"
		alias
			"IsNewContextOK"
		end

	freeze (new_context: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT) is
		external
			"IL deferred signature (System.Runtime.Remoting.Contexts.Context): System.Void use System.Runtime.Remoting.Contexts.IContextProperty"
		alias
			"Freeze"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY
