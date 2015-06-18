note
	description: "Proxy on a {CMS_STORAGE_SQL_I} interface."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PROXY_STORAGE_SQL

inherit
	CMS_STORAGE_SQL_I

create
	make

feature {NONE} -- Initialization

	make (a_sql_storage: like sql_storage)
		do
			sql_storage := a_sql_storage
		end

	sql_storage: CMS_STORAGE_SQL_I

feature -- Access

	api: detachable CMS_API
			-- Associated CMS api.
		do
			Result := sql_storage.api
		end

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			Result := sql_storage.error_handler
		end

feature -- Execution

	sql_begin_transaction
		do
			sql_storage.sql_begin_transaction
		end

	sql_rollback_transaction
		do
			sql_storage.sql_rollback_transaction
		end

	sql_commit_transaction
		do
			sql_storage.sql_commit_transaction
		end

	sql_post_execution
			-- Post database execution.
			-- note: execute after each `sql_query' and `sql_change'.
		do
			sql_storage.sql_post_execution
		end

feature -- Operation

	sql_query (a_sql_statement: STRING; a_params: detachable STRING_TABLE [detachable ANY])
		do
			sql_storage.sql_query (a_sql_statement, a_params)
		end

	sql_change (a_sql_statement: STRING; a_params: detachable STRING_TABLE [detachable ANY])
		do
			sql_storage.sql_change (a_sql_statement, a_params)
		end

feature -- Access		

	sql_rows_count: INTEGER
			-- Number of rows for last sql execution.	
		do
			Result := sql_storage.sql_rows_count
		end

	sql_start
			-- Set the cursor on first element.
		do
			sql_storage.sql_start
		end

	sql_after: BOOLEAN
			-- Are there no more items to iterate over?	
		do
			Result := sql_storage.sql_after
		end

	sql_forth
			-- Fetch next row from last sql execution, if any.
		do
			sql_storage.sql_forth
		end

	sql_valid_item_index (a_index: INTEGER): BOOLEAN
		do
			Result := sql_storage.sql_valid_item_index (a_index)
		end

	sql_item (a_index: INTEGER): detachable ANY
		do
			Result:= sql_storage.sql_item (a_index)
		end

feature -- Conversion

	sql_statement (a_statement: STRING): STRING
			-- <Precursor>
		do
			Result := sql_storage.sql_statement (a_statement)
		end

end
