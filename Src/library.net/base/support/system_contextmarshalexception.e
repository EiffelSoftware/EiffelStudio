indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ContextMarshalException"

external class
	SYSTEM_CONTEXTMARSHALEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_context_marshal_exception_1,
	make_context_marshal_exception_2,
	make_context_marshal_exception

feature {NONE} -- Initialization

	frozen make_context_marshal_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.ContextMarshalException"
		end

	frozen make_context_marshal_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ContextMarshalException"
		end

	frozen make_context_marshal_exception is
		external
			"IL creator use System.ContextMarshalException"
		end

end -- class SYSTEM_CONTEXTMARSHALEXCEPTION
