note
	description: "[
			User credential validation.
			This provides a simple way to add new source for credentials or users management.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_CREDENTIAL_VALIDATION

feature -- Access

	id: STRING
		deferred
		end

feature -- Status report

	user_with_credential (a_user_identifier: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL): detachable CMS_USER
				-- User validating credential `a_user_identifier` and `a_password`, if any.
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
