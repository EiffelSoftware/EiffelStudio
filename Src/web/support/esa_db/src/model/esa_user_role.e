note
	description: "Summary description for {USER_ROLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER_ROLE

create
	make

feature -- Initialization
	make (a_synopsis: STRING; a_description: STRING)
		do
			synopsis := a_synopsis
			description := a_description
		ensure
			synopsis_set:  synopsis = a_synopsis
			description_set: description = a_description
		end

feature -- Access

	synopsis: STRING
			-- Role synopsis

	description: STRING
			-- Role description

feature -- Status Report

	is_administrator: BOOLEAN
			-- Is user an administrator?
		do
			Result := synopsis.same_string ("Admin")
		end

	is_user: BOOLEAN
			-- Is user an user?
		do
			Result := synopsis.same_string ("User")
		end

	is_internal_user: BOOLEAN
			-- Is  user an internal user?
		do
			Result := synopsis.same_string ("InternalUser")
		end

	is_responsible: BOOLEAN
			-- Is user a problem report responsible?
		do
			Result := synopsis.same_string ("Responsible")
		end

	is_guest: BOOLEAN
			-- Is user a problem report guest?
		do
			Result := synopsis.same_string ("Guest")
		end


end
