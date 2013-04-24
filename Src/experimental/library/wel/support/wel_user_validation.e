note
	description: "Perform checking of user credential."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_USER_VALIDATION

create
	default_create

feature -- Validation

	is_user_credential_valid (a_domain, a_username, a_password: READABLE_STRING_GENERAL): BOOLEAN
			-- Is the pair `a_username'/`a_password' a valid credential in `a_domain'?
		local
			l_domain, l_username, l_password: WEL_STRING
		do
			create l_domain.make (a_domain)
			create l_username.make (a_username)
			create l_password.make (a_password)
			Result := cwel_is_credential_valid (l_domain.item, l_username.item, l_password.item)
		end

feature {NONE} -- Implementation

	cwel_is_credential_valid (a_domain, a_username, a_password: POINTER): BOOLEAN
		external
			"C inline use %"wel_user_validation.h%""
		alias
			"return cwel_is_credential_valid ((LPTSTR) $a_domain, (LPTSTR) $a_username, (LPTSTR) $a_password);"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
