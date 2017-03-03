note
	description: "Summary description for {CMS_OAUTH_20_STORAGE_SQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_STORAGE_SQL

inherit
	CMS_OAUTH_20_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_OAUTH_20_STORAGE_I

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access User Outh

	user_oauth2_without_consumer_by_token (a_token: READABLE_STRING_GENERAL): detachable CMS_USER
			-- Retrieve user by token `a_token' searching in all the registered consumers in the system.
		local
			l_list: LIST [STRING]
		do
			error_handler.reset
			write_information_log (generator + ".user_oauth2_without_consumer_by_token")
			l_list := oauth2_consumers
			from
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				Result := user_oauth2_by_token (a_token, l_list.item)
				l_list.forth
			end
		end

	user_oauth2_by_id (a_uid: like {CMS_USER}.id; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_string: STRING
			l_uid: INTEGER_64
		do
			error_handler.reset
			write_information_log (generator + ".user_oauth2_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_uid, "uid")
			create l_string.make_from_string (select_user_id_oauth2_template_by_id)
			l_string.replace_substring_all ("$table_name", oauth2_sql_table_name (a_consumer))
			sql_query (l_string, l_parameters)
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (1)
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					l_uid := 0
				end
			end
			sql_finalize
			if l_uid > 0 and attached api as l_cms_api then
				Result := l_cms_api.user_api.user_by_id (l_uid)
			end
		end

	user_oauth2_by_email (a_email: like {CMS_USER}.email; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_string: STRING
			l_uid: INTEGER_64
		do
			error_handler.reset
			write_information_log (generator + ".user_oauth2_by_email")
			create l_parameters.make (1)
			l_parameters.put (a_email, "email")
			create l_string.make_from_string (select_user_id_oauth2_template_by_email)
			l_string.replace_substring_all ("$table_name", oauth2_sql_table_name (a_consumer))
			sql_query (l_string, l_parameters)
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (1)
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					l_uid := 0
				end
			end
			sql_finalize
			if l_uid > 0 and attached api as l_cms_api then
				Result := l_cms_api.user_api.user_by_id (l_uid)
			end
		end

	user_oauth2_by_token (a_token: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_string: STRING
			l_uid: INTEGER_64
		do
			error_handler.reset
			write_information_log (generator + ".user_by_oauth2_token")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			create l_string.make_from_string (select_user_id_by_oauth2_template_token)
			l_string.replace_substring_all ("$table_name", oauth2_sql_table_name (a_consumer))
			sql_query (l_string, l_parameters)
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (1)
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					l_uid := 0
				end
			end
			sql_finalize
			if l_uid > 0 and attached api as l_cms_api then
				Result := l_cms_api.user_api.user_by_id (l_uid)
			end
		end

feature --Access: Consumers	

	oauth2_consumers: LIST [STRING]
			-- Return a list of consumers, or empty
		do
			error_handler.reset
			create {ARRAYED_LIST [STRING]} Result.make (0)
			write_information_log (generator + ".user_by_oauth2_token")
			sql_query (Sql_oauth_consumers, Void)
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					if attached sql_read_string (1) as l_name then
						Result.force (l_name)
					end
					sql_forth
				end
			end
			sql_finalize
		end

	oauth_consumer_by_name (a_name: READABLE_STRING_8): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".oauth_consumer_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name, "name")
			sql_query (sql_oauth_consumer_name, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_consumer
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					Result := Void
				end
			end
			sql_finalize
		end

	oauth_consumer_by_callback  (a_callback: READABLE_STRING_8): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by callback `a_callback', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".oauth_consumer_by_callback")
			create l_parameters.make (1)
			l_parameters.put (a_callback, "name")
			sql_query (sql_oauth_consumer_callback, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_consumer
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					Result := Void
				end
			end
			sql_finalize
		end

feature -- Change: User OAuth

	new_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer: READABLE_STRING_GENERAL)
			-- Add a new user with oauth2  authentication.
		-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_string: STRING
		do
			error_handler.reset
			sql_begin_transaction

			write_information_log (generator + ".new_user_oauth2")
			create l_parameters.make (4)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (a_user_profile, "profile")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			l_parameters.put (a_user.email, "email")


			create l_string.make_from_string (sql_insert_oauth2_template)
			l_string.replace_substring_all ("$table_name", oauth2_sql_table_name (a_consumer))
			sql_insert (l_string, l_parameters)
			sql_commit_transaction
			sql_finalize
		end

	update_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_32; a_user: CMS_USER; a_consumer: READABLE_STRING_GENERAL )
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_string: STRING
		do
			error_handler.reset
			sql_begin_transaction

			write_information_log (generator + ".new_user_oauth2")
			create l_parameters.make (4)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (a_user_profile, "profile")

			create l_string.make_from_string (sql_update_oauth2_template)
			l_string.replace_substring_all ("$table_name", oauth2_sql_table_name (a_consumer))
			sql_modify (l_string, l_parameters)
			sql_commit_transaction
			sql_finalize
		end

	remove_user_oauth2 (a_user: CMS_USER; a_consumer: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_string: STRING
		do
			error_handler.reset
			sql_begin_transaction

			write_information_log (generator + ".remove_user_oauth2")
			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")

			create l_string.make_from_string (sql_remove_oauth2_template)
			l_string.replace_substring_all ("$table_name", oauth2_sql_table_name (a_consumer))
			sql_modify (l_string, l_parameters)
			sql_commit_transaction
			sql_finalize
		end

feature {NONE} -- Implementation OAuth Consumer

	fetch_consumer: detachable CMS_OAUTH_20_CONSUMER
		do
			if attached sql_read_integer_64 (1) as l_id then
				create Result.make_with_id (l_id)

				if attached sql_read_string (2) as l_name then
					Result.set_name (l_name)
				end
				if attached sql_read_string (3) as l_api_secret then
					Result.set_api_secret (l_api_secret)
				end
				if attached sql_read_string (4) as l_api_key then
					Result.set_api_key (l_api_key)
				end
				if attached sql_read_string (5) as l_scope then
					Result.set_scope (l_scope)
				end
				if attached sql_read_string (6) as l_resource_url then
					Result.set_protected_resource_url (l_resource_url)
				end
				if attached sql_read_string (7) as l_callback_name then
					Result.set_callback_name (l_callback_name)
				end
				if attached sql_read_string (8) as l_extractor then
					Result.set_extractor (l_extractor)
				end
				if attached sql_read_string (9) as l_authorize_url then
					Result.set_authorize_url (l_authorize_url)
				end
				if attached sql_read_string (10) as l_endpoint then
					Result.set_endpoint (l_endpoint)
				end
			end
		end

feature {NONE} -- User OAuth2

	oauth2_sql_table_name (a_consumer: READABLE_STRING_GENERAL): STRING_8
		local
			i,n: INTEGER
		do
			create Result.make_from_string (Sql_oauth2_table_prefix)
			if a_consumer.is_valid_as_string_8 then
				Result.append (a_consumer.to_string_8)
			else
				check only_ascii: False end
					-- Replace non ascii char by '-'
				from
					i := 1
					n := a_consumer.count
				until
					i > n
				loop
					if a_consumer [i].is_character_8 then
						Result.append_code (a_consumer.code (i))
					else
						Result.append_character ('-')
					end
					i := i + 1
				end
			end
		end

	Select_user_id_by_oauth2_template_token: STRING = "SELECT uid FROM $table_name WHERE access_token = :token;"
			--| User id for access token :token

	Select_user_id_oauth2_template_by_id: STRING = "SELECT uid FROM $table_name WHERE uid = :uid;"

	Select_user_id_oauth2_template_by_email: STRING = "SELECT uid FROM $table_name WHERE email = :email;"


--	Select_user_by_oauth2_template_token: STRING = "SELECT u.* FROM users as u JOIN $table_name as og ON og.uid = u.uid and og.access_token = :token;"
--			--| FIXME: replace the u.* by a list of field names, to avoid breaking `featch_user' if two fieds are swiped.

--	Select_user_oauth2_template_by_id: STRING = "SELECT u.* FROM users as u JOIN $table_name as og ON og.uid = u.uid and og.uid = :uid;"

--	Select_user_oauth2_template_by_email: STRING = "SELECT u.* FROM users as u JOIN $table_name as og ON og.uid = u.uid and og.email = :email;"

	Sql_insert_oauth2_template: STRING = "INSERT INTO $table_name (uid, access_token, details, created, email) VALUES (:uid, :token, :profile, :utc_date, :email);"

	Sql_update_oauth2_template: STRING = "UPDATE $table_name SET access_token = :token, details = :profile WHERE uid =:uid;"

	Sql_remove_oauth2_template: STRING = "DELETE FROM $table_name WHERE uid =:uid;"

	Sql_oauth_consumers: STRING = "SELECT name FROM oauth2_consumers;"

	Sql_oauth2_table_prefix: STRING = "oauth2_"

feature {NONE} -- Consumer

	Sql_oauth_consumer_callback: STRING = "SELECT * FROM oauth2_consumers where callback_name =:name;"

	Sql_oauth_consumer_name: STRING = "SELECT * FROM oauth2_consumers where name =:name;"

end
