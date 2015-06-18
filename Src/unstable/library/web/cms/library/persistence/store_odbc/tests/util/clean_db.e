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

class
	CLEAN_DB

feature

	clean_db (a_connection: DATABASE_CONNECTION)
			-- Clean db test.
		local
			l_parameters: STRING_TABLE[STRING]
		do
			create l_parameters.make (0)

			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_nodes, l_parameters))
			db_handler(a_connection).execute_change

				-- Clean Users
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_users, l_parameters))
			db_handler(a_connection).execute_change

--				-- Reset Autoincremente
--			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_users_autoincrement, l_parameters))
--			db_handler(a_connection).execute_change

--			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Rest_nodes_autoincrement, l_parameters))
--			db_handler(a_connection).execute_change
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

	Rest_users_autoincrement: STRING = "ALTER TABLE Users AUTO_INCREMENT = 1"
		-- reset autoincrement

	Rest_nodes_autoincrement: STRING = "ALTER TABLE Nodes AUTO_INCREMENT = 1"
		-- reset autoincrement.

end
