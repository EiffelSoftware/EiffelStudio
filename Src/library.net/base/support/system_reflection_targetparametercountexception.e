indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.TargetParameterCountException"

frozen external class
	SYSTEM_REFLECTION_TARGETPARAMETERCOUNTEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_target_parameter_count_exception_1,
	make_target_parameter_count_exception,
	make_target_parameter_count_exception_2

feature {NONE} -- Initialization

	frozen make_target_parameter_count_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.TargetParameterCountException"
		end

	frozen make_target_parameter_count_exception is
		external
			"IL creator use System.Reflection.TargetParameterCountException"
		end

	frozen make_target_parameter_count_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetParameterCountException"
		end

end -- class SYSTEM_REFLECTION_TARGETPARAMETERCOUNTEXCEPTION
