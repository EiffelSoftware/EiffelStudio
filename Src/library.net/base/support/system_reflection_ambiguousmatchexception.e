indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.AmbiguousMatchException"

frozen external class
	SYSTEM_REFLECTION_AMBIGUOUSMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_ambiguous_match_exception_2,
	make_ambiguous_match_exception,
	make_ambiguous_match_exception_1

feature {NONE} -- Initialization

	frozen make_ambiguous_match_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.AmbiguousMatchException"
		end

	frozen make_ambiguous_match_exception is
		external
			"IL creator use System.Reflection.AmbiguousMatchException"
		end

	frozen make_ambiguous_match_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AmbiguousMatchException"
		end

end -- class SYSTEM_REFLECTION_AMBIGUOUSMATCHEXCEPTION
