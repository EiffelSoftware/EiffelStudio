indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.TargetException"

external class
	SYSTEM_REFLECTION_TARGETEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_target_exception,
	make_target_exception_2,
	make_target_exception_1

feature {NONE} -- Initialization

	frozen make_target_exception is
		external
			"IL creator use System.Reflection.TargetException"
		end

	frozen make_target_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetException"
		end

	frozen make_target_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.TargetException"
		end

end -- class SYSTEM_REFLECTION_TARGETEXCEPTION
