indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ContextStaticAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CONTEXT_STATIC_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_context_static_attribute

feature {NONE} -- Initialization

	frozen make_context_static_attribute is
		external
			"IL creator use System.ContextStaticAttribute"
		end

end -- class CONTEXT_STATIC_ATTRIBUTE
