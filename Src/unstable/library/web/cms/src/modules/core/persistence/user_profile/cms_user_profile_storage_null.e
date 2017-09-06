note
	description: "Summary description for {CMS_USER_PROFILE_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_PROFILE_STORAGE_NULL

inherit
	CMS_USER_PROFILE_STORAGE_I

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access

	user_profile (a_user: CMS_USER): detachable CMS_USER_PROFILE
			-- <Precursor>
		do
		end

	users_with_profile_item (a_item_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL): detachable LIST [CMS_USER]
			-- <Precursor>
		do
		end

feature -- Change

	save_user_profile (a_user: CMS_USER; a_profile: CMS_USER_PROFILE)
			-- <Precursor>
		do
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
