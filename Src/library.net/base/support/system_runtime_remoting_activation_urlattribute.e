indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Activation.UrlAttribute"

frozen external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATION_URLATTRIBUTE

inherit
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXTATTRIBUTE
		redefine
			get_properties_for_new_context,
			is_context_ok,
			get_hash_code,
			is_equal
		end
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY

create
	make_urlattribute

feature {NONE} -- Initialization

	frozen make_urlattribute (callsite_url: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Activation.UrlAttribute"
		end

feature -- Access

	frozen get_url_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"get_UrlValue"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"GetHashCode"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"Equals"
		end

	get_properties_for_new_context (ctor_msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	is_context_ok (ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT; msg: SYSTEM_RUNTIME_REMOTING_ACTIVATION_ICONSTRUCTIONCALLMESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"IsContextOK"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATION_URLATTRIBUTE
