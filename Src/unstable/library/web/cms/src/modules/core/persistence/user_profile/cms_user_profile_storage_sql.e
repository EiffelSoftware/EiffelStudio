note
	description: "Interface for accessing user profile contents from SQL database."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER_PROFILE_STORAGE_SQL

inherit
	CMS_USER_PROFILE_STORAGE_I
		redefine
			user_profile_item,
			save_user_profile_item
		end

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

create
	make

feature -- Access

	user_profile_item (a_user: CMS_USER; a_item_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- User profile for `a_user'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_parameters.make (2)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_item_name, "key")
			sql_query (sql_select_user_profile_item, l_parameters)
			if not has_error then
				Result := sql_read_string_32 (2)
			end
			sql_finalize_query (sql_select_user_profile_item)
		end

	user_profile (a_user: CMS_USER): detachable CMS_USER_PROFILE
			-- User profile for `a_user'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			reset_error
			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")
			sql_query (sql_select_user_profile_items, l_parameters)
			if not has_error then
				create Result.make
				from
					sql_start
				until
					sql_after or has_error
				loop
					if
						attached sql_read_string_32 (1) as l_key and
						attached sql_read_string_32 (2) as l_val
					then
						Result.force (l_val, l_key)
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_user_profile_items)
		end

	users_with_profile_item (a_item_name: READABLE_STRING_GENERAL; a_value: detachable READABLE_STRING_GENERAL): detachable LIST [CMS_USER]
			-- Users having a profile item `a_item_name:a_value`.
			-- Note: if `a_value` is Void, return users having a profile item named `a_item_name`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uids: ARRAYED_LIST [INTEGER_64]
		do
			reset_error
			create l_parameters.make (2)
			l_parameters.put (a_item_name, "key")
			if a_value = Void then
				sql_query (sql_select_users_with_profile_item_named, l_parameters)
			else
				l_parameters.put (a_value, "value")
				sql_query (sql_select_users_with_profile_item, l_parameters)
			end
			if not has_error then
				create l_uids.make (0)
				from
					sql_start
				until
					sql_after or has_error
				loop
					if
						attached sql_read_integer_64 (1) as l_uid and then
						l_uid > 0
					then
						l_uids.force (l_uid)
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_users_with_profile_item)
			if
				not has_error and
				l_uids /= Void and
				attached api as l_cms_api
			then
				create {ARRAYED_LIST [CMS_USER]} Result.make (l_uids.count)
				across
					l_uids as ic
				loop
					if attached l_cms_api.user_api.user_by_id (ic.item) as u then
						Result.force (u)
					else
						check known_user: False end
					end
				end
			end
		end

feature -- Change

	save_user_profile_item (a_user: CMS_USER; a_item_name: READABLE_STRING_GENERAL; a_item_value: READABLE_STRING_GENERAL)
			-- Save user profile item `a_item_name:a_item_value` for `a_user'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_item_name, "key")
			l_parameters.put (a_item_value, "value")

			reset_error
			if user_profile_item (a_user, a_item_name) = Void then
				sql_insert (sql_insert_user_profile_item, l_parameters)
				sql_finalize_insert (sql_insert_user_profile_item)
			else
				sql_modify (sql_update_user_profile_item, l_parameters)
				sql_finalize_modify (sql_update_user_profile_item)
			end
		end

	save_user_profile (a_user: CMS_USER; a_profile: CMS_USER_PROFILE)
			-- Save user profile `a_profile' for `a_user'.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			p: detachable CMS_USER_PROFILE
			l_item: like user_profile_item
			l_is_new: BOOLEAN
			l_has_diff: BOOLEAN
		do
			p := user_profile (a_user)

			create l_parameters.make (3)

			reset_error
			across
				a_profile as ic
			until
				has_error
			loop
				l_item := ic.item
						-- No previous profile, or no item with same name, or same value
				l_has_diff := True
				if p = Void then
					l_is_new := True
				elseif p.has_key (ic.key) then
					l_is_new := False
					l_has_diff := attached p.item (ic.key) as l_prev_item and then
									not l_prev_item.same_string (l_item)
				else
					l_is_new := True
				end
				if l_has_diff then
					l_parameters.put (a_user.id, "uid")
					l_parameters.put (ic.key, "key")
					l_parameters.put (l_item, "value")

					if l_is_new then
						sql_insert (sql_insert_user_profile_item, l_parameters)
						sql_finalize_insert (sql_insert_user_profile_item)
					else
						sql_modify (sql_update_user_profile_item, l_parameters)
						sql_finalize_modify (sql_update_user_profile_item)
					end
					l_parameters.wipe_out
				end
			end
		end

feature {NONE} -- Queries

	sql_select_user_profile_items: STRING = "SELECT `key`, value FROM user_profiles WHERE uid=:uid;"
			-- user profile items for :uid;

	sql_select_user_profile_item: STRING = "SELECT `key`, value FROM user_profiles WHERE uid=:uid AND `key`=:key"
			-- user profile items for :uid;

	sql_select_users_with_profile_item: STRING = "SELECT uid FROM user_profiles WHERE `key`=:key and value=:value"
			-- users with profile item named :key and value :value;

	sql_select_users_with_profile_item_named: STRING = "SELECT uid FROM user_profiles WHERE `key`=:key"
			-- users with profile item named :key;

	sql_insert_user_profile_item: STRING = "INSERT INTO user_profiles (uid, `key`, value) VALUES (:uid, :key, :value);"
			-- new user profile item for :uid;

	sql_update_user_profile_item: STRING = "UPDATE user_profiles SET value = :value WHERE uid = :uid AND `key`=:key;"
			-- user profile items for :uid;


note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

