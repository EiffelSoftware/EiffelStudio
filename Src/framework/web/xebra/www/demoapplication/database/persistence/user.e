note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_name: STRING; a_password: STRING; a_is_admin: BOOLEAN)
			-- Initialization for `Current'.
		require
			not_a_password_is_detached_or_empty: a_password /= Void and then not a_password.is_empty
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
		do
			id := a_id
			name:= a_name
			password:= a_password
			is_admin:= a_is_admin
		ensure
			name_attached: name /= Void
			password_attached: password /= Void
		end

feature -- Access

	id: INTEGER
	name: STRING
	password: STRING
	is_admin: BOOLEAN

invariant
	name_attached: name /= Void
	password_attached: password /= Void
end
