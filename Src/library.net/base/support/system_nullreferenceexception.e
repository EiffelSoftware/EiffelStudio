indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.NullReferenceException"

external class
	SYSTEM_NULLREFERENCEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_nullreferenceexception,
	make_nullreferenceexception_2,
	make_nullreferenceexception_1

feature {NONE} -- Initialization

	frozen make_nullreferenceexception is
		external
			"IL creator use System.NullReferenceException"
		end

	frozen make_nullreferenceexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.NullReferenceException"
		end

	frozen make_nullreferenceexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.NullReferenceException"
		end

end -- class SYSTEM_NULLREFERENCEEXCEPTION
