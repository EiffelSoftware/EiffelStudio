note
	description: "User for temporary account."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TEMP_USER

inherit
	CMS_USER
		redefine
			is_active
		end

create
	make,
	make_with_id

feature -- Access

	personal_information: detachable STRING_32
			-- User personal information.

	salt: detachable STRING_32
			-- User's password salt.

	is_active: BOOLEAN = False
			-- <Precursor/>.

feature -- Element change

	set_personal_information (a_personal_information: detachable READABLE_STRING_GENERAL)
			-- Assign `personal_information` with `a_personal_information`.
		do
			if a_personal_information = Void then
				personal_information := Void
			else
				personal_information := a_personal_information.as_string_32
			end
		ensure
			personal_information_assigned: a_personal_information /= Void 
					implies (attached personal_information as inf and then 
								a_personal_information.same_string (inf))
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
