indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.TargetInvocationException"

frozen external class
	SYSTEM_REFLECTION_TARGETINVOCATIONEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_targetinvocationexception_1,
	make_targetinvocationexception

feature {NONE} -- Initialization

	frozen make_targetinvocationexception_1 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetInvocationException"
		end

	frozen make_targetinvocationexception (inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Reflection.TargetInvocationException"
		end

end -- class SYSTEM_REFLECTION_TARGETINVOCATIONEXCEPTION
