indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MemberAccessException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MEMBER_ACCESS_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_member_access_exception,
	make_member_access_exception_2,
	make_member_access_exception_1

feature {NONE} -- Initialization

	frozen make_member_access_exception is
		external
			"IL creator use System.MemberAccessException"
		end

	frozen make_member_access_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MemberAccessException"
		end

	frozen make_member_access_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.MemberAccessException"
		end

end -- class MEMBER_ACCESS_EXCEPTION
