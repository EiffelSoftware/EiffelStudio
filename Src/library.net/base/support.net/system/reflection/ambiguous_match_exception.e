indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AmbiguousMatchException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	AMBIGUOUS_MATCH_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_ambiguous_match_exception,
	make_ambiguous_match_exception_1,
	make_ambiguous_match_exception_2

feature {NONE} -- Initialization

	frozen make_ambiguous_match_exception is
		external
			"IL creator use System.Reflection.AmbiguousMatchException"
		end

	frozen make_ambiguous_match_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AmbiguousMatchException"
		end

	frozen make_ambiguous_match_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.AmbiguousMatchException"
		end

end -- class AMBIGUOUS_MATCH_EXCEPTION
