indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.InvalidFilterCriteriaException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	INVALID_FILTER_CRITERIA_EXCEPTION

inherit
	APPLICATION_EXCEPTION
	ISERIALIZABLE

create
	make_invalid_filter_criteria_exception_2,
	make_invalid_filter_criteria_exception_1,
	make_invalid_filter_criteria_exception

feature {NONE} -- Initialization

	frozen make_invalid_filter_criteria_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.InvalidFilterCriteriaException"
		end

	frozen make_invalid_filter_criteria_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.InvalidFilterCriteriaException"
		end

	frozen make_invalid_filter_criteria_exception is
		external
			"IL creator use System.Reflection.InvalidFilterCriteriaException"
		end

end -- class INVALID_FILTER_CRITERIA_EXCEPTION
