indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.TargetException"

external class
	SYSTEM_REFLECTION_TARGETEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_targetexception,
	make_targetexception_2,
	make_targetexception_1

feature {NONE} -- Initialization

	frozen make_targetexception is
		external
			"IL creator use System.Reflection.TargetException"
		end

	frozen make_targetexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetException"
		end

	frozen make_targetexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.TargetException"
		end

end -- class SYSTEM_REFLECTION_TARGETEXCEPTION
