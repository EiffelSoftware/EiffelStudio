indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UnauthorizedAccessException"

external class
	SYSTEM_UNAUTHORIZEDACCESSEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_unauthorizedaccessexception_1,
	make_unauthorizedaccessexception,
	make_unauthorizedaccessexception_2

feature {NONE} -- Initialization

	frozen make_unauthorizedaccessexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.UnauthorizedAccessException"
		end

	frozen make_unauthorizedaccessexception is
		external
			"IL creator use System.UnauthorizedAccessException"
		end

	frozen make_unauthorizedaccessexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.UnauthorizedAccessException"
		end

end -- class SYSTEM_UNAUTHORIZEDACCESSEXCEPTION
