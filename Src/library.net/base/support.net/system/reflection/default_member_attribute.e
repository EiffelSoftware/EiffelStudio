indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.DefaultMemberAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DEFAULT_MEMBER_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_default_member_attribute

feature {NONE} -- Initialization

	frozen make_default_member_attribute (member_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.DefaultMemberAttribute"
		end

feature -- Access

	frozen get_member_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Reflection.DefaultMemberAttribute"
		alias
			"get_MemberName"
		end

end -- class DEFAULT_MEMBER_ATTRIBUTE
