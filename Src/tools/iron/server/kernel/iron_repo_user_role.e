note
	description: "Summary description for {IRON_REPO_USER_ROLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_USER_ROLE

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_role_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_role_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := name.is_case_insensitive_equal (other.name)
		end

end
