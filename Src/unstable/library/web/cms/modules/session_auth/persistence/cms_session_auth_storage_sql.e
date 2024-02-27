note
	description: "Summary description for {CMS_SESSION_AUTH_STORAGE_SQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_STORAGE_SQL

inherit
	CMS_SESSION_AUTH_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access User

	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- Retrieve user by token `a_token', if any.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uid: INTEGER_64
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (Select_user_id_by_token, l_parameters)
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (1)
				sql_forth
				if not sql_after then
					check
						no_more_than_one: False
					end
					l_uid := 0
				end
			end
			sql_finalize_query (Select_user_id_by_token)
			if l_uid > 0 and attached api as l_cms_api then
				Result := l_cms_api.user_api.user_by_id (l_uid)
			end
		end

	has_user_token (a_user: CMS_USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
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
			sql_finalize_query (Select_user_token)
		end

feature -- Change User token

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			sql_begin_transaction
			sql_insert (sql_insert_session_auth, l_parameters)
			sql_finalize_insert (sql_insert_session_auth)
			sql_commit_transaction
		end

	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_token, "token")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "utc_date")
			sql_begin_transaction
			sql_modify (sql_update_session_auth, l_parameters)
			sql_finalize_modify (sql_update_session_auth)
			sql_commit_transaction
		end

feature {NONE} -- SQL statements

	Select_user_id_by_token: STRING = "SELECT uid FROM auth_session WHERE access_token = :token;"

	sql_insert_session_auth: STRING = "INSERT INTO auth_session (uid, access_token, created) VALUES (:uid, :token, :utc_date);"

	sql_update_session_auth: STRING = "UPDATE auth_session SET access_token = :token, created = :utc_date WHERE uid =:uid;"

	select_user_token: STRING = "SELECT COUNT(*) FROM auth_session where uid = :uid;"

end
