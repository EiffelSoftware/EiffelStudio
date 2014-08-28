note
	description: "Summary description for {CMS_USER_ROLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_ROLE

inherit
	ANY
		redefine
			is_equal
		end

create
	make,
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_id: like id; a_name: like name)
		do
			id := a_id
			make (a_name)
		end

	make (a_name: like name)
		do
			name := a_name
			create {ARRAYED_LIST [READABLE_STRING_8]} permissions.make (0)
		end

feature -- Status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	has_permission (p: READABLE_STRING_8): BOOLEAN
		do
			Result := across permissions as c some c.item.is_case_insensitive_equal (p) end
		end

feature -- Access

	id: INTEGER

	name: READABLE_STRING_8

	permissions: LIST [READABLE_STRING_8]

feature -- Comparison

	same_user_role (r: CMS_USER_ROLE): BOOLEAN
		do
			Result := r.id = id
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := id = other.id
		end

feature -- Change

	set_id (a_id: like id)
		do
			id := a_id
		end

	set_name (a_name: like name)
		do
			name := a_name
		end

	add_permission (n: READABLE_STRING_8)
		do
			permissions.force (n)
		end

end
