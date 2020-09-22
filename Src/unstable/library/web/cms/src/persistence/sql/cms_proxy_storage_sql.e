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
				-- FIXME: may raise exception due to locked database...
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

	sql_query (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
		do
			sql_storage.sql_query (a_sql_statement, a_params)
		end

	sql_finalize
			-- Finalize sql query (i.e destroy previous query statement.
		do
			sql_storage.sql_finalize
			if
				has_error and then
				attached api as l_cms_api
			then
				l_cms_api.log_error ("database", generator + "." + l_cms_api.html_encoded (error_handler.as_string_representation), Void)
			end
		end

	sql_insert (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
		do
			sql_storage.sql_insert (a_sql_statement, a_params)
		end

	sql_modify (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
		do
			sql_storage.sql_modify (a_sql_statement, a_params)
		end

	sql_delete (a_sql_statement: READABLE_STRING_8; a_params: detachable STRING_TABLE [detachable ANY])
		do
			sql_storage.sql_delete (a_sql_statement, a_params)
		end

feature -- Access		

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

	sql_read_integer_32 (a_index: INTEGER_32): INTEGER_32
		do
			Result := sql_storage.sql_read_integer_32 (a_index)
		end

	sql_read_date_time (a_index: INTEGER_32): detachable DATE_TIME
		do
			Result := sql_storage.sql_read_date_time (a_index)
		end

feature -- Conversion

	sql_statement (a_statement: READABLE_STRING_8): READABLE_STRING_8
			-- <Precursor>
		do
			Result := sql_storage.sql_statement (a_statement)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
