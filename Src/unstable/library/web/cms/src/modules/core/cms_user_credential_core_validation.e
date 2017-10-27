note
	description: "Summary description for {CMS_USER_CREDENTIAL_CORE_VALIDATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_CREDENTIAL_CORE_VALIDATION

inherit
	CMS_USER_CREDENTIAL_VALIDATION

create
	make

feature {NONE} -- Creation

	make (a_api: CMS_API; a_storage: CMS_USER_STORAGE_I)
		do
			user_storage := a_storage
			cms_api := a_api
		end

	cms_api: CMS_API

feature -- Access

	id: STRING = "core"

	user_storage: CMS_USER_STORAGE_I

feature -- Status report

	user_with_credential (a_user_identifier: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL): detachable CMS_USER
				-- User validating credentials `a_user_identifier` and `a_password`, if any.
		do
				-- Check by username, by email
				-- and also check temp user...
			Result := user_storage.user_with_credential (a_user_identifier, a_password)
			if Result = Void and then a_user_identifier.has ('@') then
					-- Try with email
				if attached user_storage.user_by_email (a_user_identifier) as u then
					Result := user_storage.user_with_credential (u.name, a_password)
				end
			end
			if Result = Void then
				Result := user_storage.temp_user_with_credential (a_user_identifier, a_password)
				if Result = Void and then a_user_identifier.has ('@') then
						-- Try with email
					if attached user_storage.temp_user_by_email (a_user_identifier) as u then
						Result := user_storage.temp_user_with_credential (u.name, a_password)
					end
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
