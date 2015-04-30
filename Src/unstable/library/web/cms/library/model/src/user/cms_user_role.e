note
	description: "[
			The user roles are used for the CMS permission system.
			A role has a list of permissions, that describes what users of current role
			are authorized to operation.
		]"
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

	make_with_id (a_id: like id)
			-- Create current role with role id `a_id'.
		do
			id := a_id
			name := {STRING_32} ""
			initialize
		end

	make (a_name: like name)
			-- Create current role with name `a_name'.
		require
			a_name_valid: not a_name.is_whitespace
		do
			name := a_name
			initialize
		end

	initialize
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} permissions.make (0)
		end

feature -- Status report

	has_id: BOOLEAN
			-- Has a unique identifier?
		do
			Result := id > 0
		end

	has_permission (p: READABLE_STRING_GENERAL): BOOLEAN
			-- Has permission `p'?
		do
			Result := across permissions as c some p.is_case_insensitive_equal (c.item) end
		end

feature -- Access

	id: INTEGER
			-- Unique id associated with Current role.

	name: READABLE_STRING_32
			-- Name of Current role.

	permissions: LIST [READABLE_STRING_8]
			-- List of permissions.

feature -- Comparison

	same_user_role (other: CMS_USER_ROLE): BOOLEAN
			-- Is Current role same as role `other' ?
		do
			Result := other.id = id
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := id = other.id
		end

feature -- Change

	set_id (a_id: like id)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			set_id: id = a_id
		end

	set_name (a_name: like name)
			-- Set `name' with `a_name'.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

feature -- Permission change

	add_permission (a_permission_name: READABLE_STRING_8)
			-- Add permission `a_permission_name' to Current role.
		require
			is_not_blank: not a_permission_name.is_whitespace
		do
			permissions.force (a_permission_name)
		ensure
			has_permission: has_permission (a_permission_name)
		end

	remove_permission (a_permission_name: READABLE_STRING_8)
			-- Remove permission `a_permission_name' from Current role.
		require
			is_not_blank: not a_permission_name.is_whitespace
		do
			permissions.prune_all (a_permission_name)
		ensure
			not_has_permission: not has_permission (a_permission_name)
		end

note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
