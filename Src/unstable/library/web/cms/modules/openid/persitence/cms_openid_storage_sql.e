note
	description: "Summary description for {CMS_OPENID_STORAGE_SQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_STORAGE_SQL

inherit
	CMS_OPENID_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_OPENID_STORAGE_I

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access User Outh

	user_openid_by_userid_identity (a_uid: like {CMS_USER}.id; a_identity: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_openid_by_userid_identity")
			create l_parameters.make (1)
			l_parameters.put (a_uid, "uid")
			l_parameters.put (a_identity, "identity")
			sql_query (Select_user_openid_by_id, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_user
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					Result := Void
				end
			end
			sql_finalize
		end

	user_openid_by_identity (a_identity: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_openid_by_identity")
			create l_parameters.make (1)
			l_parameters.put (a_identity, "identity")
			sql_query (Select_user_by_openid_identity, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_user
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					Result := Void
				end
			else
				check no_more_than_one: False end
			end
			sql_finalize
		end

feature --Access: Consumers	

	openid_consumers: LIST [STRING]
			-- Return a list of consumers, or empty
		do
			error_handler.reset
			create {ARRAYED_LIST [STRING]} Result.make (0)
			write_information_log (generator + ".openid_consumers")
			sql_query (Sql_openid_consumers, Void)
			if not has_error then
				from
					sql_start
				until
					sql_after
				loop
					if attached sql_read_string (1) as l_name then
						Result.force (l_name)
					end
					sql_forth
				end
			end
			sql_finalize
		end

	openid_consumer_by_name (a_name: READABLE_STRING_8): detachable CMS_OPENID_CONSUMER
			-- Retrieve a consumer by name `a_name', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".openid_consumer_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name, "name")
			sql_query (sql_openid_consumer_name, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_consumer
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
				end
			end
			sql_finalize
		end

feature -- Change: User OAuth

	new_user_openid (a_identity: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- Add a new user with openid authentication.
		-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			sql_begin_transaction

			write_information_log (generator + ".new_user_openid")
			create l_parameters.make (4)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_identity, "identity")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			sql_insert (Sql_insert_openid, l_parameters)
			sql_commit_transaction
			sql_finalize
		end

feature {NONE} -- Implementation OAuth Consumer

	fetch_consumer: detachable CMS_OPENID_CONSUMER
		do
			if attached sql_read_integer_64 (1) as l_id then
				create Result.make_with_id (l_id)

				if attached sql_read_string (2) as l_name then
					Result.set_name (l_name)
				end
				if attached sql_read_string (3) as l_endpoint then
					Result.set_endpoint (l_endpoint)
				end
			end
		end

feature {NONE} -- Implementation: User

	fetch_user: detachable CMS_USER
		local
			l_id: INTEGER_64
			l_name: detachable READABLE_STRING_32
		do
			if attached sql_read_integer_64 (1) as i then
				l_id := i
			end
			if attached sql_read_string_32 (2) as s and then not s.is_whitespace then
				l_name := s
			end

			if l_name /= Void then
				create Result.make (l_name)
				if l_id > 0 then
					Result.set_id (l_id)
				end
			elseif l_id > 0 then
				create Result.make_with_id (l_id)
			end

			if Result /= Void then
				if attached sql_read_string (3) as l_password then
						-- FIXME: should we return the password here ???
					Result.set_hashed_password (l_password)
				end
				if attached sql_read_string (5) as l_email then
					Result.set_email (l_email)
				end
				if attached sql_read_integer_32 (6) as l_status then
					Result.set_status (l_status)
				end
			else
				check expected_valid_user: False end
			end
		end

feature {NONE} -- User OpenID


	Select_user_by_openid_identity: STRING = "SELECT u.* FROM users as u JOIN openid_items as og ON og.uid = u.uid and og.identity = :identity;"
		--| FIXME: replace the u.* by a list of field names, to avoid breaking `featch_user' if two fieds are swiped.

	Select_user_openid_by_id: STRING = "SELECT u.* FROM users as u JOIN openid_items as og ON og.uid = u.uid and og.uid = :uid and og.identity = :identity;"

	Sql_insert_openid: STRING = "INSERT INTO openid_items (uid, identity, created) VALUES (:uid, :identity, :utc_date);"

	Sql_openid_consumers: STRING = "SELECT name FROM openid_consumers;"


feature {NONE} -- Consumer

	Sql_openid_consumer_name: STRING = "SELECT * FROM openid_consumers where name =:name;"

end
