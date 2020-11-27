note
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_STORAGE_SQL

inherit
	LOGIN_WITH_ESA_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Access User Outh

	esa_account_for_user (u: CMS_USER): detachable ESA_ACCOUNT
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (u.id, "uid")
			sql_query (sql_select_esa_account, l_parameters)
			if not has_error and not sql_after then
				if attached sql_read_string_32 (2) as l_username then
					create Result.make_with_username (l_username)
					if attached sql_read_string_8 (3) as l_email then
						Result.set_email (l_email)
					end
				end
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					Result := Void
				end
			end
			sql_finalize_query (sql_select_esa_account)
		end

	user_for_esa_name (a_esa_name: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uid: INTEGER_64
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_esa_name, "name")
			sql_query (sql_select_uid_by_name, l_parameters)
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (1)
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					l_uid := 0
				end
			end
			sql_finalize_query (sql_select_uid_by_name)
			if l_uid > 0 and attached api as l_cms_api then
				Result := l_cms_api.user_api.user_by_id (l_uid)
			end
		end

	user_for_esa_email (a_email: READABLE_STRING_GENERAL): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uid: INTEGER_64
		do
			error_handler.reset
			create l_parameters.make (1)
			l_parameters.put (a_email, "email")
			sql_query (sql_select_uid_by_email, l_parameters)
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (1)
				sql_forth
				if not sql_after then
					check no_more_than_one: False end
					l_uid := 0
				end
			end
			sql_finalize_query (sql_select_uid_by_email)
			if l_uid > 0 and attached api as l_cms_api then
				Result := l_cms_api.user_api.user_by_id (l_uid)
			end
		end

feature -- Record

	associate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (3)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_esa_account.username, "name")
			l_parameters.put (a_esa_account.email, "email")

			reset_error
			sql_insert (sql_insert_esa_association, l_parameters)
			sql_finalize_insert (sql_insert_esa_association)
		end

	dissociate_esa_account (a_user: CMS_USER; a_esa_account : ESA_ACCOUNT)
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (2)
			l_parameters.put (a_user.id, "uid")
			l_parameters.put (a_esa_account.username, "name")

			reset_error
			sql_delete (sql_delete_esa_association, l_parameters)
			sql_finalize_delete (sql_delete_esa_association)
		end

feature -- SQL queries

	sql_select_esa_account: STRING = "SELECT uid, name, email FROM login_with_esa WHERE uid=:uid ;"

	sql_select_uid_by_name: STRING = "SELECT uid, name, email FROM login_with_esa WHERE name=:name ;"

	sql_select_uid_by_email: STRING = "SELECT uid, name, email FROM login_with_esa WHERE email=:email ;"

	sql_insert_esa_association: STRING = "INSERT INTO login_with_esa (uid, name, email) VALUES (:uid, :name, :email) ;"

	sql_delete_esa_association: STRING = "DELETE FROM login_with_esa WHERE uid=:uid AND name=:name ;"

invariant

end
