indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AmbiguousMatchException"

frozen external class
	SYSTEM_REFLECTION_AMBIGUOUSMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_ambiguousmatchexception_2,
	make_ambiguousmatchexception,
	make_ambiguousmatchexception_1

feature {NONE} -- Initialization

	frozen make_ambiguousmatchexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.AmbiguousMatchException"
		end

	frozen make_ambiguousmatchexception is
		external
			"IL creator use System.Reflection.AmbiguousMatchException"
		end

	frozen make_ambiguousmatchexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.AmbiguousMatchException"
		end

end -- class SYSTEM_REFLECTION_AMBIGUOUSMATCHEXCEPTION
