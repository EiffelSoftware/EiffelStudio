indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.ContextProperty"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CONTEXT_PROPERTY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	get_property: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Contexts.ContextProperty"
		alias
			"get_Property"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Contexts.ContextProperty"
		alias
			"get_Name"
		end

end -- class CONTEXT_PROPERTY
