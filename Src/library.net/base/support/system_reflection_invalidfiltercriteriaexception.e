indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.InvalidFilterCriteriaException"

external class
	SYSTEM_REFLECTION_INVALIDFILTERCRITERIAEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidfiltercriteriaexception_1,
	make_invalidfiltercriteriaexception_2,
	make_invalidfiltercriteriaexception

feature {NONE} -- Initialization

	frozen make_invalidfiltercriteriaexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.InvalidFilterCriteriaException"
		end

	frozen make_invalidfiltercriteriaexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.InvalidFilterCriteriaException"
		end

	frozen make_invalidfiltercriteriaexception is
		external
			"IL creator use System.Reflection.InvalidFilterCriteriaException"
		end

end -- class SYSTEM_REFLECTION_INVALIDFILTERCRITERIAEXCEPTION
