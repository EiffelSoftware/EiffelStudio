indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.TargetParameterCountException"

frozen external class
	SYSTEM_REFLECTION_TARGETPARAMETERCOUNTEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_targetparametercountexception_1,
	make_targetparametercountexception,
	make_targetparametercountexception_2

feature {NONE} -- Initialization

	frozen make_targetparametercountexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.TargetParameterCountException"
		end

	frozen make_targetparametercountexception is
		external
			"IL creator use System.Reflection.TargetParameterCountException"
		end

	frozen make_targetparametercountexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetParameterCountException"
		end

end -- class SYSTEM_REFLECTION_TARGETPARAMETERCOUNTEXCEPTION
