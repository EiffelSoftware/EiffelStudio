indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ArrayTypeMismatchException"

external class
	SYSTEM_ARRAYTYPEMISMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_array_type_mismatch_exception_1,
	make_array_type_mismatch_exception,
	make_array_type_mismatch_exception_2

feature {NONE} -- Initialization

	frozen make_array_type_mismatch_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.ArrayTypeMismatchException"
		end

	frozen make_array_type_mismatch_exception is
		external
			"IL creator use System.ArrayTypeMismatchException"
		end

	frozen make_array_type_mismatch_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArrayTypeMismatchException"
		end

end -- class SYSTEM_ARRAYTYPEMISMATCHEXCEPTION
