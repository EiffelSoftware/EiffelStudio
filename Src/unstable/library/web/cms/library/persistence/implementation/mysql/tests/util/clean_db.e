note
	description: "[
		    Setting up database tests
			1. Put the database in a known state before running your test suite.
			2. Data reinitialization. For testing in developer sandboxes, something that you should do every time you rebuild the system, you may want to forgo dropping and rebuilding the database in favor of simply reinitializing the source data. 
				You can do this either by erasing all existing data and then inserting the initial data vales back into the database, or you can simple run updates to reset the data values. 
			   	The first approach is less risky and may even be faster for large amounts of data. - See more at: http://www.agiledata.org/essays/databaseTesting.html#sthash.6yVp35g8.dpuf
		]"

	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Database Testing", "src=http://www.agiledata.org/essays/databaseTesting.html", "protocol=uri"
	testing:"execution/serial"

class
	CLEAN_DB

feature

	clean_db (a_connection: DATABASE_CONNECTION)
			-- Clean db test.
		local
			l_parameters: STRING_TABLE[STRING]
		do
			create l_parameters.make (0)

			a_connection.begin_transaction

				-- Clean Profiles
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_user_profiles, l_parameters))
			db_handler(a_connection).execute_change

				-- Clean Permissions
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_permissions, l_parameters))
			db_handler(a_connection).execute_change


				-- Clean Users Nodes
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_users_nodes, l_parameters))
			db_handler(a_connection).execute_change


				-- Clean Users Roles
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_users_roles, l_parameters))
			db_handler(a_connection).execute_change

				-- Clean Roles
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_roles, l_parameters))
			db_handler(a_connection).execute_change

				-- Clean Nodes
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_nodes, l_parameters))
			db_handler(a_connection).execute_change

				-- Clean Users
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_users, l_parameters))
			db_handler(a_connection).execute_change


				-- Reset Autoincremente
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_users_autoincrement, l_parameters))
			db_handler(a_connection).execute_change

			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_nodes_autoincrement, l_parameters))
			db_handler(a_connection).execute_change

			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_roles_autoincrement, l_parameters))
			db_handler(a_connection).execute_change

			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_permissions_autoincrement, l_parameters))
			db_handler(a_connection).execute_change

			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_profiles_autoincrement, l_parameters))
			db_handler(a_connection).execute_change

			a_connection.commit
		end



feature -- Database Hanlder

	db_handler (a_connection: DATABASE_CONNECTION): DATABASE_HANDLER
			-- Db handler
		once
			create {DATABASE_HANDLER_IMPL} Result.make (a_connection)
		end


feature -- Sql delete queries

	Sql_delete_users: STRING = "delete from Users"
		-- Clean Users.

	Sql_delete_nodes: STRING = "delete from Nodes"
		-- Clean Nodes.

	Sql_delete_roles: STRING = "delete from Roles"
		-- Clean Roles.

	Sql_delete_permissions: STRING = "delete from Permissions"
		-- Clean Permissions.

	Sql_delete_users_roles: STRING = "delete from Users_roles"
		-- Clean User roles.

	Sql_delete_user_profiles: STRING = "delete from profiles"
		-- Clean profiles.

	Sql_delete_users_nodes: STRING = "delete from users_nodes"

	Rest_users_autoincrement: STRING = "ALTER TABLE Users AUTO_INCREMENT = 1"
		-- reset autoincrement

	Rest_nodes_autoincrement: STRING = "ALTER TABLE Nodes AUTO_INCREMENT = 1"
		-- reset autoincrement.

	Rest_roles_autoincrement: STRING = "ALTER TABLE Roles AUTO_INCREMENT = 1"
		-- reset autoincrement.

	Rest_permissions_autoincrement: STRING = "ALTER TABLE Permissions AUTO_INCREMENT = 1"
		-- reset autoincrement.

	Rest_profiles_autoincrement: STRING = "ALTER TABLE Profiles AUTO_INCREMENT = 1"
		-- reset autoincrement.



end
