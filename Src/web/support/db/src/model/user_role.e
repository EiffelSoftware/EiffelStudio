note
	description: "[
				Objects that represent a user role
				
				The role of a user can be one of the following:
					Guest   Anonymous visitor.
					User	Eiffel Software web site user.
					Admin	Eiffel Software web site administrator.
					InternalUser	Internal user, has access to special pr categories but cannot edit web site.
					Responsible	Eiffel Software developer, responsible for fixing reported problems.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	USER_ROLE

create
	make

feature {NONE} -- Initialization

	make (a_synopsis: READABLE_STRING_32; a_description: READABLE_STRING_32)
			-- Create an object instance
			-- Set `synopsis' to `a_synopsis'
			-- Set `description' to `a_description'.
		do
			synopsis := a_synopsis
			description := a_description
		ensure
			synopsis_set:  synopsis = a_synopsis
			description_set: description = a_description
		end

feature -- Access

	synopsis: STRING_32
			-- Role synopsis.

	description: STRING_32
			-- Role description.

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
