indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.InvalidFilterCriteriaException"

external class
	SYSTEM_REFLECTION_INVALIDFILTERCRITERIAEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalid_filter_criteria_exception_1,
	make_invalid_filter_criteria_exception_2,
	make_invalid_filter_criteria_exception

feature {NONE} -- Initialization

	frozen make_invalid_filter_criteria_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.InvalidFilterCriteriaException"
		end

	frozen make_invalid_filter_criteria_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.InvalidFilterCriteriaException"
		end

	frozen make_invalid_filter_criteria_exception is
		external
			"IL creator use System.Reflection.InvalidFilterCriteriaException"
		end

end -- class SYSTEM_REFLECTION_INVALIDFILTERCRITERIAEXCEPTION
