indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ArrayTypeMismatchException"

external class
	SYSTEM_ARRAYTYPEMISMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_arraytypemismatchexception_1,
	make_arraytypemismatchexception,
	make_arraytypemismatchexception_2

feature {NONE} -- Initialization

	frozen make_arraytypemismatchexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.ArrayTypeMismatchException"
		end

	frozen make_arraytypemismatchexception is
		external
			"IL creator use System.ArrayTypeMismatchException"
		end

	frozen make_arraytypemismatchexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArrayTypeMismatchException"
		end

end -- class SYSTEM_ARRAYTYPEMISMATCHEXCEPTION
