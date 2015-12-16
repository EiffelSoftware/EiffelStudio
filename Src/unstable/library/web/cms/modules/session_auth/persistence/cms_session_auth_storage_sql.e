note
	description: "Summary description for {CMS_SESSION_AUTH_STORAGE_SQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_STORAGE_SQL

inherit

	CMS_SESSION_AUTH_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_SESSION_AUTH_STORAGE_I

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access User

	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- Retrieve user by token `a_token', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".user_by_session_token")
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (Select_user_by_token, l_parameters)
			if not has_error and not sql_after then
				Result := fetch_user
				sql_forth
				if not sql_after then
					check
						no_more_than_one: False
					end
					Result := Void
				end
			end
			sql_finalize
		end

	has_user_token (a_user: CMS_USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".has_user_token")
			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")
			sql_query (Select_user_token, l_parameters)
			if not has_error and not sql_after then
				if sql_read_integer_64 (1) = 1 then
					Result := True
				else
					Result := False
				end
			end
			sql_finalize
		end

feature -- Change User token

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER;)
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".new_user_session")
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			sql_begin_transaction
			sql_insert (sql_insert_session_auth, l_parameters)
			sql_commit_transaction
			sql_finalize
		end

	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".update_user_session_auth")
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			sql_begin_transaction
			sql_modify (sql_update_session_auth, l_parameters)
			sql_commit_transaction
			sql_finalize
		end

feature {NONE} -- Implementation

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
				check
					expected_valid_user: False
				end
			end
		end

feature {NONE} -- SQL statements

	Select_user_by_token: STRING = "SELECT u.* FROM users as u JOIN session_auth as og ON og.uid = u.uid and og.access_token = :token;"
			--| FIXME: replace the u.* by a list of field names, to avoid breaking `featch_user' if two fieds are swiped.

	Sql_insert_session_auth: STRING = "INSERT INTO session_auth (uid, access_token, created) VALUES (:uid, :token, :utc_date);"

	Sql_update_session_auth: STRING = "UPDATE session_auth SET access_token = :token, created = :utc_date WHERE uid =:uid;"

	Select_user_token: STRING = "SELECT COUNT(*) FROM session_auth where uid = :uid;"

end
