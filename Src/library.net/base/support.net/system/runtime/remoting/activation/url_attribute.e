indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Activation.UrlAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	URL_ATTRIBUTE

inherit
	CONTEXT_ATTRIBUTE
		redefine
			get_properties_for_new_context,
			is_context_ok,
			get_hash_code,
			equals
		end
	ICONTEXT_ATTRIBUTE
	ICONTEXT_PROPERTY

create
	make_url_attribute

feature {NONE} -- Initialization

	frozen make_url_attribute (callsite_url: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Activation.UrlAttribute"
		end

feature -- Access

	frozen get_url_value: SYSTEM_STRING is
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

	get_properties_for_new_context (ctor_msg: ICONSTRUCTION_CALL_MESSAGE) is
		external
			"IL signature (System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Void use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"GetPropertiesForNewContext"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"Equals"
		end

	is_context_ok (ctx: CONTEXT; msg: ICONSTRUCTION_CALL_MESSAGE): BOOLEAN is
		external
			"IL signature (System.Runtime.Remoting.Contexts.Context, System.Runtime.Remoting.Activation.IConstructionCallMessage): System.Boolean use System.Runtime.Remoting.Activation.UrlAttribute"
		alias
			"IsContextOK"
		end

end -- class URL_ATTRIBUTE
