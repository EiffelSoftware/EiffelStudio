note
	description: "Interface for accessing user profile contents from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_USER_PROFILE_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

	user_profile (a_user: CMS_USER): detachable CMS_USER_PROFILE
			-- User profile for `a_user'.
		require
			has_id: a_user.has_id
		deferred
		end

	user_profile_item (a_user: CMS_USER; a_item_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		require
			valid_user: a_user.has_id
		do
			if attached user_profile (a_user) as pf then
				Result := pf.item (a_item_name)
			end
		end

	users_with_profile_item (a_item_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL): detachable LIST [CMS_USER]
			-- Users having a profile item `a_item_name:a_value`.
			-- Note: if `a_value` is Void, return users having a profile item named `a_item_name`.
		deferred
		end

feature -- Change

	save_user_profile (a_user: CMS_USER; a_profile: CMS_USER_PROFILE)
			-- Save user profile `a_profile' for `a_user'.
		require
			user_has_id: a_user.has_id
		deferred
		end

	save_user_profile_item (a_user: CMS_USER; a_profile_item_name: READABLE_STRING_GENERAL; a_profile_item_value: READABLE_STRING_GENERAL)
		require
			user_has_id: a_user.has_id
		local
			pf: detachable CMS_USER_PROFILE
		do
			pf := user_profile (a_user)
			if pf = Void then
				create pf.make
			end
			pf.force (a_profile_item_value, a_profile_item_name)
			save_user_profile (a_user, pf)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
