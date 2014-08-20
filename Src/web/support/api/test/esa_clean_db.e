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
	ESA_CLEAN_DB

feature

	clean_db (a_connection: DATABASE_CONNECTION)
				-- Number of rows for the given query `a_query' using parameters `a_parameters'
		local
			l_parameters: STRING_TABLE[STRING]
		do
			create l_parameters.make (0)
			a_connection.connect
				-- Clean registrations
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_registrations, l_parameters))
			db_handler(a_connection).execute_query

				-- Clean Membershios
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_memberships, l_parameters))
			db_handler(a_connection).execute_query

				-- Clean Contacts
			db_handler(a_connection).set_query (create {DATABASE_QUERY}.data_reader (Sql_delete_contacts, l_parameters))
			db_handler(a_connection).execute_query

			a_connection.disconnect
		end



feature -- Database Hanlder

	db_handler (a_connection: DATABASE_CONNECTION): DATABASE_HANDLER
			-- Db handler
		once
			create {DATABASE_HANDLER_IMPL} Result.make (a_connection)
		end


feature -- Sql delete queries

	Sql_delete_registrations: STRING = "delete from Registrations"
		-- Clean registrations

	Sql_delete_memberships: STRING = "delete from Memberships"
		-- Clean memberships

	Sql_delete_contacts: STRING = "delete from Contacts"
		-- Clean contacts
end
