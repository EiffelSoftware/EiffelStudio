indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.InvalidOperationException"

external class
	SYSTEM_INVALIDOPERATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidoperationexception,
	make_invalidoperationexception_2,
	make_invalidoperationexception_1

feature {NONE} -- Initialization

	frozen make_invalidoperationexception is
		external
			"IL creator use System.InvalidOperationException"
		end

	frozen make_invalidoperationexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.InvalidOperationException"
		end

	frozen make_invalidoperationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.InvalidOperationException"
		end

end -- class SYSTEM_INVALIDOPERATIONEXCEPTION
