indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.MemberAccessException"

external class
	SYSTEM_MEMBERACCESSEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_memberaccessexception,
	make_memberaccessexception_2,
	make_memberaccessexception_1

feature {NONE} -- Initialization

	frozen make_memberaccessexception is
		external
			"IL creator use System.MemberAccessException"
		end

	frozen make_memberaccessexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MemberAccessException"
		end

	frozen make_memberaccessexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.MemberAccessException"
		end

end -- class SYSTEM_MEMBERACCESSEXCEPTION
