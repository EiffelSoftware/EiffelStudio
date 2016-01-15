note
	description: "User for temporary account."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TEMP_USER

inherit
	CMS_USER

create
	make,
	make_with_id

feature -- Access

	personal_information: detachable STRING_32
			-- User personal information.

	salt: detachable STRING_32
			-- User's password salt.

feature -- Element change

	set_personal_information (a_personal_information: like personal_information)
			-- Assign `personal_information' with `a_personal_information'.
		do
			personal_information := a_personal_information
		ensure
			personal_information_assigned: personal_information = a_personal_information
		end

	set_salt (a_salt: like salt)
			-- Assign `salt' with `a_salt'.
		do
			salt := a_salt
		ensure
			salt_assigned: salt = a_salt
		end

note
	copyright: "2011-2016, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
