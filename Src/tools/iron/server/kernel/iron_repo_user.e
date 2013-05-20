note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_USER

create
	make

feature {NONE} -- Initialization

	make (u: like name)
			-- Initialize `Current'.
		do
			name := u
		end

feature -- Access

	name: READABLE_STRING_32

	password: detachable READABLE_STRING_32

	is_administrator: BOOLEAN
			-- Is considered as administrator?

	roles: detachable LIST [IRON_REPO_USER_ROLE]
			-- Associated user roles.

feature -- Status report

	same_user (other: IRON_REPO_USER): BOOLEAN
			-- Is other same user as Current?
		do
			Result := name.is_case_insensitive_equal (other.name)
		end

feature -- Change

	set_password (p: like password)
		do
			password := p
		end

	set_is_administrator (b: BOOLEAN)
		do
			is_administrator := b
		end

	add_role (r: IRON_REPO_USER_ROLE)
		local
			l_roles: like roles
		do
			l_roles := roles
			if l_roles = Void then
				create {ARRAYED_LIST [IRON_REPO_USER_ROLE]} l_roles.make (1)
				roles := l_roles
			end
			l_roles.extend (r)
			if r.name.is_case_insensitive_equal ("admin") then
				is_administrator := True
			end
		end

	remove_role (r: IRON_REPO_USER_ROLE)
		local
			l_roles: like roles
		do
			l_roles := roles
			if l_roles /= Void then
				l_roles.prune_all (r)
			end
			if r.name.is_case_insensitive_equal ("admin") then
				is_administrator := False
			end
		end

end
