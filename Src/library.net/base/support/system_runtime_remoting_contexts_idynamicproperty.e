indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Contexts.IDynamicProperty"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_IDYNAMICPROPERTY

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
			"IL deferred signature (): System.String use System.Runtime.Remoting.Contexts.IDynamicProperty"
		alias
			"get_Name"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_IDYNAMICPROPERTY
