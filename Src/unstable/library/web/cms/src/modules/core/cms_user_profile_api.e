note
	description: "API to handle user profiles."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_PROFILE_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
					-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {CMS_USER_PROFILE_STORAGE_SQL} user_profile_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_USER_PROFILE_STORAGE_NULL} user_profile_storage
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	user_profile_storage: CMS_USER_PROFILE_STORAGE_I

feature -- Access: profile

	user_profile (a_user: CMS_USER): detachable CMS_USER_PROFILE
			-- User profile for `a_user'.
		require
			valid_user: a_user.has_id
		do
			Result := user_profile_storage.user_profile (a_user)
		end

	user_profile_item (a_item_name: READABLE_STRING_GENERAL; a_user: CMS_USER): detachable READABLE_STRING_32
			-- User profile item `a_item_name` for `a_user`.
		require
			valid_user: a_user.has_id
		do
			Result := user_profile_storage.user_profile_item (a_user, a_item_name)
		end

	users_with_profile_item (a_item_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL): detachable LIST [CMS_USER]
			-- Users having a profile item `a_item_name:a_value`.
			-- Note: if `a_value` is Void, return users having a profile item named `a_item_name`.
		require
			not a_item_name.is_whitespace
		do
			Result := user_profile_storage.users_with_profile_item (a_item_name, a_value)
		end

feature -- Change: profile

	save_user_profile (a_user: CMS_USER; a_user_profile: CMS_USER_PROFILE)
			-- Save `a_user' profile `a_user_profile'.
		require
			valid_user: a_user.has_id
		do
			user_profile_storage.save_user_profile (a_user, a_user_profile)
		end

	save_user_profile_item (a_user: CMS_USER; a_user_profile_name, a_user_profile_value: READABLE_STRING_GENERAL)
			-- Save `a_user' profile item `a_user_profile_name=a_user_profile_value`.
		require
			valid_user: a_user.has_id
		do
			user_profile_storage.save_user_profile_item (a_user, a_user_profile_name, a_user_profile_value)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
