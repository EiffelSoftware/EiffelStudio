indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.DefaultMemberAttribute"

frozen external class
	SYSTEM_REFLECTION_DEFAULTMEMBERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_default_member_attribute

feature {NONE} -- Initialization

	frozen make_default_member_attribute (memberName2: STRING) is
		external
			"IL creator signature (System.String) use System.Reflection.DefaultMemberAttribute"
		end

feature -- Access

	frozen get_member_name: STRING is
		external
			"IL signature (): System.String use System.Reflection.DefaultMemberAttribute"
		alias
			"get_MemberName"
		end

end -- class SYSTEM_REFLECTION_DEFAULTMEMBERATTRIBUTE
