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

feature -- Change

	set_password (p: like password)
		do
			password := p
		end

end
