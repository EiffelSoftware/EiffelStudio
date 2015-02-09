note
	description: "Summary description for {CMS_STORAGE_STORE_SQL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE_STORE_SQL

inherit
	CMS_STORAGE

	CMS_STORAGE_SQL

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			--
		require
			is_connected: a_connection.is_connected
		do
			connection := a_connection
			log.write_information (generator + ".make - is database connected?  "+ a_connection.is_connected.out )

			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)

			create error_handler.make
--			error_handler.add_synchronization (db_handler.database_error_handler)
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is storage available?
		do
			Result := connection.is_connected
		end

feature {NONE} -- Implementation	

	db_handler: DATABASE_HANDLER

	connection: DATABASE_CONNECTION
			-- Current database connection.	

feature -- Query

	sql_post_execution
			-- Post database execution.
		do
			error_handler.append (db_handler.database_error_handler)
			if error_handler.has_error then
				log.write_critical (generator + ".post_execution " +  error_handler.as_string_representation)
			end
		end

	sql_begin_transaction
		do
			connection.begin_transaction
		end

	sql_rollback_transaction
		do
			connection.rollback
		end

	sql_commit_transaction
		do
			connection.commit
		end

	sql_query (a_sql_statement: STRING; a_params: detachable STRING_TABLE [detachable ANY])
		do
			check_sql_query_validity (a_sql_statement, a_params)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (a_sql_statement, a_params))
			db_handler.execute_query
		end

	sql_change (a_sql_statement: STRING; a_params: detachable STRING_TABLE [detachable ANY])
		do
			check_sql_query_validity (a_sql_statement, a_params)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (a_sql_statement, a_params))
			db_handler.execute_change
		end

	sql_rows_count: INTEGER
			-- Number of rows for last sql execution.	
		do
			Result := db_handler.count
		end

	sql_start
			-- Set the cursor on first element.
		do
			db_handler.start
		end

	sql_after: BOOLEAN
			-- Are there no more items to iterate over?	
		do
			Result := db_handler.after
		end

	sql_forth
			-- Fetch next row from last sql execution, if any.
		do
			db_handler.forth
		end

	sql_item (a_index: INTEGER): detachable ANY
		do
			if attached {DB_TUPLE} db_handler.item as l_item and then l_item.count >= a_index then
				Result := l_item.item (a_index)
			else
				check has_item_at_index: False end
			end
		end

end
