indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ContextMarshalException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CONTEXT_MARSHAL_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_context_marshal_exception_1,
	make_context_marshal_exception_2,
	make_context_marshal_exception

feature {NONE} -- Initialization

	frozen make_context_marshal_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ContextMarshalException"
		end

	frozen make_context_marshal_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ContextMarshalException"
		end

	frozen make_context_marshal_exception is
		external
			"IL creator use System.ContextMarshalException"
		end

end -- class CONTEXT_MARSHAL_EXCEPTION
