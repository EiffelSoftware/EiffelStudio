indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ContextMarshalException"

external class
	SYSTEM_CONTEXTMARSHALEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_contextmarshalexception_1,
	make_contextmarshalexception_2,
	make_contextmarshalexception

feature {NONE} -- Initialization

	frozen make_contextmarshalexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ContextMarshalException"
		end

	frozen make_contextmarshalexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ContextMarshalException"
		end

	frozen make_contextmarshalexception is
		external
			"IL creator use System.ContextMarshalException"
		end

end -- class SYSTEM_CONTEXTMARSHALEXCEPTION
