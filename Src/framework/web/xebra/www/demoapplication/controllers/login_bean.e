note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_BEAN

inherit
	ANY
		redefine
			out
		end

create
	make

feature -- Initialization

	make
		do
			name := ""
			password := ""
		ensure
			name_attached: attached name
			password_attached: attached password
		end

feature -- Access

	name: STRING assign set_name
			-- The name

	set_name (a_name: STRING)
			-- Sets the name
		require
			a_name_valid: attached a_name
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	password: STRING assign set_password
			-- The password

	set_password (a_password: STRING)
			-- Sets the password
		require
			a_password_valid: attached a_password
		do
			password := a_password
		ensure
			password_set: password = a_password
		end

	out: STRING
			--<Precursor>
		do
			Result := "name: '" + name + "' password: '" + password + "'"
		end

invariant
	name_attached: attached name
	password_attached: attached password

end
