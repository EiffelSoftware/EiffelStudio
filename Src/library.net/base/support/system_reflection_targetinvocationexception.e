indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.TargetInvocationException"

frozen external class
	SYSTEM_REFLECTION_TARGETINVOCATIONEXCEPTION

inherit
	SYSTEM_APPLICATIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_target_invocation_exception_1,
	make_target_invocation_exception

feature {NONE} -- Initialization

	frozen make_target_invocation_exception_1 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Reflection.TargetInvocationException"
		end

	frozen make_target_invocation_exception (inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Reflection.TargetInvocationException"
		end

end -- class SYSTEM_REFLECTION_TARGETINVOCATIONEXCEPTION
