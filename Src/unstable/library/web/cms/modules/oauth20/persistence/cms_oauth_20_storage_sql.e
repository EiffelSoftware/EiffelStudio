note
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

	user_oauth2_by_user_id (a_uid: like {CMS_USER}.id; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uid: INTEGER_64
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_uid, "uid")
			sql_query (select_user_id_oauth2_by_user_id (oauth2_sql_table_name (a_consumer)), l_parameters)
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

	user_oauth2_by_id (a_oauth_id: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uid: INTEGER_64
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_oauth_id, "id")
			sql_query (select_user_id_oauth2_by_id (oauth2_sql_table_name (a_consumer)), l_parameters)
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
			l_uid: INTEGER_64
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (select_user_id_by_oauth2_token (oauth2_sql_table_name (a_consumer)), l_parameters)
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

	oauth_consumer_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
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

	oauth_consumer_by_callback  (a_callback: READABLE_STRING_GENERAL): detachable CMS_OAUTH_20_CONSUMER
			-- Retrieve a consumer by callback `a_callback', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
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

	save_oauth_consumer (a_cons: CMS_OAUTH_20_CONSUMER)
			-- Save consumer `a_cons`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_table: STRING
		do
			error_handler.reset
			if a_cons.has_id then
				create l_parameters.make (10)
				l_parameters.put (a_cons.id, "cid")
			else
				create l_parameters.make (9)
			end
			l_parameters.put (a_cons.name, "name")
			l_parameters.put (a_cons.api_secret, "api_secret")
			l_parameters.put (a_cons.api_key, "api_key")
			l_parameters.put (a_cons.scope, "scope")
			l_parameters.put (a_cons.protected_resource_url, "protected_resource_url")
			l_parameters.put (a_cons.callback_name, "callback_name")
			l_parameters.put (a_cons.extractor, "extractor")
			l_parameters.put (a_cons.authorize_url, "authorize_url")
			l_parameters.put (a_cons.endpoint, "endpoint")

			if a_cons.has_id then
				sql_modify (sql_update_oauth2_consumers, l_parameters)
			else
				sql_insert (sql_insert_oauth2_consumers, l_parameters)
			end
			sql_finalize
			if not has_error then
				l_table := oauth2_sql_table_name (a_cons.name)
				if not sql_table_exists (l_table) then
						-- FIXME: shouldn't we use a unique table for all oauth providers? or as it is .. one table per oauth provider?
					sql_execute_script (sql_oauth2_create_table (l_table), Void)
					sql_finalize
				end
			end
		end

	delete_oauth_consumer (a_cons: CMS_OAUTH_20_CONSUMER)
			-- Save consumer `a_cons`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_table, l_new_table: STRING
			htdate: HTTP_DATE
		do
			error_handler.reset
			if a_cons.has_id then
				create l_parameters.make (10)
				l_parameters.put (a_cons.id, "cid")

				sql_delete (sql_delete_oauth2_consumers, l_parameters)
				sql_finalize
				if not has_error then
					l_table := oauth2_sql_table_name (a_cons.name)
					if sql_table_exists (l_table) then
						create htdate.make_now_utc
						create l_new_table.make_from_string (l_table)
						l_new_table.append_character ('_')
						l_new_table.append (htdate.timestamp.out)
						sql_execute_script (sql_oauth2_rename_table (l_table, l_new_table), Void)
						sql_finalize
					end
				end
			end
		end

	new_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_GENERAL; a_user: CMS_USER; a_oauth_id: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL)
			-- Add a new user with oauth2  authentication.
		-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (4)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (a_user_profile, "profile")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			l_parameters.put (a_oauth_id, "id")

			sql_insert (sql_insert_oauth2 (oauth2_sql_table_name (a_consumer)), l_parameters)
			sql_finalize
		end

	update_user_oauth2 (a_token: READABLE_STRING_GENERAL; a_user_profile: READABLE_STRING_GENERAL; a_user: CMS_USER; a_oauth_id: READABLE_STRING_GENERAL; a_consumer: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (4)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (a_user_profile, "profile")
			l_parameters.put (a_oauth_id, "id")

			sql_modify (sql_update_oauth2 (oauth2_sql_table_name (a_consumer)), l_parameters)
			sql_finalize
		end

	remove_user_oauth2 (a_user: CMS_USER; a_consumer: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset

			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")

			sql_modify (sql_remove_oauth2 (oauth2_sql_table_name (a_consumer)), l_parameters)
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

	Select_user_id_by_oauth2_token (a_table: READABLE_STRING_8): STRING
		do
			Result := "SELECT uid FROM " + a_table + " WHERE access_token = :token;"
		end
			--| User id for access token :token

	select_user_id_oauth2_by_user_id (a_table: READABLE_STRING_8): STRING
		do
			Result := "SELECT uid FROM " + a_table + " WHERE uid = :uid;"
		end

	select_user_id_oauth2_by_id (a_table: READABLE_STRING_8): STRING
		do
			Result := "SELECT uid FROM " + a_table + " WHERE id = :id;"
		end

	Sql_insert_oauth2 (a_table: READABLE_STRING_8): STRING
		do
			Result := "INSERT INTO " + a_table + " (uid, access_token, details, created, id) VALUES (:uid, :token, :profile, :utc_date, :id);"
		end

	Sql_update_oauth2 (a_table: READABLE_STRING_8): STRING
		do
			Result := "UPDATE " + a_table + " SET access_token = :token, details = :profile , id = :id WHERE uid =:uid;"
		end

	Sql_remove_oauth2 (a_table: READABLE_STRING_8): STRING
		do
			Result := "DELETE FROM " + a_table + " WHERE uid =:uid;"
		end

	Sql_oauth_consumers: STRING = "SELECT name FROM oauth2_consumers;"

	Sql_oauth2_table_prefix: STRING = "oauth2_"

	sql_oauth2_create_table (a_table_name: READABLE_STRING_8): STRING
		do
			create Result.make_from_string ("CREATE TABLE ")
			Result.append (a_table_name)
			Result.append ("[
					(
					`uid` INTEGER PRIMARY KEY NOT NULL CHECK(`uid`>=0),
					`access_token` TEXT  NOT NULL,
					`created` DATETIME NOT NULL,
					`details` TEXT NOT NULL,
					`id` VARCHAR (250) NOT NULL,
					CONSTRAINT `uid`
						UNIQUE(`uid`),
					CONSTRAINT `id`
						UNIQUE(`id`)
					);
				]")
		end

	sql_oauth2_rename_table (a_table_name, a_new_table_name: READABLE_STRING_8): STRING
		do
			create Result.make_from_string ("ALTER TABLE ")
			Result.append (a_table_name)
			Result.append (" RENAME TO ")
			Result.append (a_new_table_name)
			Result.append_character (';')
		end

feature {NONE} -- Consumer

	Sql_oauth_consumer_callback: STRING = "SELECT * FROM oauth2_consumers where callback_name =:name;"

	Sql_oauth_consumer_name: STRING = "SELECT * FROM oauth2_consumers where name =:name;"

	sql_insert_oauth2_consumers: STRING = "INSERT INTO oauth2_consumers (name, api_secret, api_key,  scope, protected_resource_url, callback_name, extractor, authorize_url, endpoint) VALUES (:name, :api_secret, :api_key,  :scope, :protected_resource_url, :callback_name, :extractor, :authorize_url, :endpoint);"

	sql_update_oauth2_consumers: STRING = "UPDATE oauth2_consumers SET name = :name, api_secret = :api_secret, api_key = :api_key, scope = :scope, protected_resource_url = :protected_resource_url, callback_name = :callback_name, extractor = :extractor, authorize_url = :authorize_url, endpoint = :endpoint WHERE cid = :cid;"

	sql_delete_oauth2_consumers: STRING = "DELETE FROM oauth2_consumers WHERE cid=:cid ;"

end
