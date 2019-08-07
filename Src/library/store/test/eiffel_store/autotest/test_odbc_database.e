note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ODBC_DATABASE

inherit

	TEST_DATABASE
		undefine
			default_create
		end

	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end


feature {NONE} -- Prepare

	on_prepare
			-- <Precursor>
		local
			l_executor: DATABASE_EXECUTOR
			l_user1: NEW_USERS
		do
				-- Initialize Database,
			create l_executor.make (odbc_connection)

				-- if the Table 'NEW_USERS' does not exist it will be created and a new User will be added.
				--| The generated data types using the repository object will depend on the data associated and also their lenght.
				--| Todo create a new SQL_create_table.
			create l_user1.make
			l_user1.set_name ("mike")
			l_user1.set_username ("mike")
			l_executor.create_item (l_user1)
			odbc_connection.db_control.commit
		end

	on_clean
		local
			l_handler: DATABASE_HANDLER_IMPL
		do
				-- Clean rows from database table 'NEW_USERS'
			create l_handler.make (odbc_connection)
			l_handler.set_query (query_delete_users)
			l_handler.execute_change
		end

feature -- Tests using NULL

	test_insert_with_null
		local
			l_handler: DATABASE_HANDLER_IMPL
			l_user: NEW_USERS
		do
				-- Database with one user
			assert ("count = 1", count_users = 1)

				-- Add a new user
			create l_handler.make (odbc_connection)
			create l_user.make
			l_user.set_username ("jim")
			l_handler.set_query (new_user (l_user))
			l_handler.execute_change

				-- Check we have 2 users
			assert ("count = 2", count_users = 2)

			-- Check NULL values in the new user
			-- Search by username 'jim'
			l_handler.set_query (query_user_by_username ("jim"))
			l_handler.execute_query
			if not l_handler.after then
				l_handler.start
					-- name, username, email, datetime, userid
					-- name = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("name = void", l_item.item (1) = Void)
				end
					--username = jim
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("username = jim", attached l_handler.read_string_32 (2) as l_username and then l_username.same_string_general ("jim"))
				end

					--email = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("email = null", l_item.item (3) = Void)
				end

					--datetime /= null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("datetime /= null", l_item.item (4) /= Void)
				end


					--userid = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("userid = null", l_item.item (5) = Void)
				end
			end
		end


	test_update_with_null
		local
			l_handler: DATABASE_HANDLER_IMPL
		do
				-- Database with one user
			assert ("count = 1", count_users = 1)

				-- Check values for the user 'mike'
				-- Search by username 'mike'

			create l_handler.make (odbc_connection)
			l_handler.set_query (query_user_by_username ("mike"))
			l_handler.execute_query
			if not l_handler.after then
				l_handler.start
					-- name, username, email, datetime, userid
					-- name = mike
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("username = mike", attached l_handler.read_string_32 (1) as l_name and then l_name.same_string_general ("mike"))
				end
					--username = jim
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("username = mike", attached l_handler.read_string_32 (2) as l_username and then l_username.same_string_general ("mike"))
				end

					--email = empty
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("email is empty",l_item.item (3) = Void)
				end

					--datetime /= null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("datetime /= null", l_item.item (4) /= Void)
				end

					--userid = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("userid = null", l_item.item (5) = Void)
				end
			end


				-- Update the user 'mike'
				-- we have something like
				-- name: mike, username: mike, email = empty, datetime= dd/mm/yyyy, userid = null

			l_handler.set_query (update_user_with_params ("joe1", Void, Void, "mike"))
			l_handler.execute_change

				-- We need to check the changes
			l_handler.set_query (query_user_by_username ("mike"))
			l_handler.execute_query
			if not l_handler.after then
				l_handler.start
					-- name, username, email, datetime, userid
					-- name = mike
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("username = joe1", attached l_handler.read_string_32 (1) as l_name and then l_name.same_string_general ("joe1"))
				end
					--username = mike123
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("username = mike", attached l_handler.read_string_32 (2) as l_username and then l_username.same_string_general ("mike"))
				end

					--email = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("email is null", l_item.item (3) = Void)
				end

					--datetime = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("datetime /= null", l_item.item (4) = Void)
				end

					--userid = null
				if attached {DB_TUPLE} l_handler.item as l_item then
					assert ("userid = null", l_item.item (5) = Void)
				end
			end
		end



feature  {NONE} -- Helper

	count_users: INTEGER_64
		local
			l_handler: DATABASE_HANDLER_IMPL
		do
			create l_handler.make (odbc_connection)
			l_handler.set_query (query_count_users)
			l_handler.execute_query
			if not l_handler.after then
				l_handler.start
				if attached {DB_TUPLE} l_handler.item as l_item then
					Result :=l_handler.read_integer_32 (1)
				end

			end
		end

end
