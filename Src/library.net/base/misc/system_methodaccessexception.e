indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.MethodAccessException"

external class
	SYSTEM_METHODACCESSEXCEPTION

inherit
	SYSTEM_MEMBERACCESSEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_methodaccessexception,
	make_methodaccessexception_1,
	make_methodaccessexception_2

feature {NONE} -- Initialization

	frozen make_methodaccessexception is
		external
			"IL creator use System.MethodAccessException"
		end

	frozen make_methodaccessexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.MethodAccessException"
		end

	frozen make_methodaccessexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MethodAccessException"
		end

end -- class SYSTEM_METHODACCESSEXCEPTION
