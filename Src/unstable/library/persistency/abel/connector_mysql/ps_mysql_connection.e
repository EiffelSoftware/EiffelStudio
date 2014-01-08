note
	description: "Wrapper for a connection to a MySQL database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_CONNECTION

inherit

	PS_SQL_CONNECTION

	PS_SQLSTATE_CONVERTER

create {PS_MYSQL_DATABASE}
	make

feature {PS_ABEL_EXPORT} -- Settings

	set_autocommit (flag: BOOLEAN)
			-- <Precursor>
		do
			internal_connection.set_flag_autocommit (flag)
			is_auto_commit_enabled := flag
		ensure then
			correctly_set: is_auto_commit_enabled = flag
		end

feature {PS_ABEL_EXPORT}

	execute_sql (statement: STRING)
			-- <Precursor>
		do
			internal_connection.execute_query (statement)
			if internal_connection.has_error then
				print (statement)
				print (internal_connection.last_error_message)
				if attached get_error as err then
					last_error := err
					err.raise
				end
			end
			last_results := compute_last_results
		end

	commit
			-- <Precursor>
		do
			internal_connection.commit
			if internal_connection.has_error then
				print (internal_connection.last_error_message)
				if attached get_error as err then
					last_error := err
					err.raise
				end
			end
		end

	rollback
			-- <Precursor>
		do
			internal_connection.rollback
			if internal_connection.has_error then
				if attached get_error as err then
					last_error := err
					err.raise
				end
			end
		end

	last_result: ITERATION_CURSOR [PS_SQL_ROW]
			-- <Precursor>
		do
			Result := last_results.last
		end

	last_results: LIST [ITERATION_CURSOR [PS_SQL_ROW]]
			-- <Precursor>

	last_error: detachable PS_ERROR
			-- <Precursor>

	last_primary_key: INTEGER
			-- <Precursor>
		do
			Result := internal_connection.last_result.last_insert_id
		end

feature {PS_MYSQL_DATABASE} -- Access

	internal_connection: MYSQLI_CLIENT
			-- The actual connection wrapped by `Current'.

feature {NONE} -- Initialization

	make (a_connection: MYSQLI_CLIENT)
			-- Initialization for `Current'.
		do
			internal_connection := a_connection
			last_error := Void
			create {ARRAYED_LIST [ITERATION_CURSOR [PS_SQL_ROW]]} last_results.make (1)
		end

feature {NONE} -- Implementation

	compute_last_results: ARRAYED_LIST [ITERATION_CURSOR [PS_SQL_ROW]]
			-- Get the last results as a linked list.
		local
			result_list: ARRAYED_LIST [PS_SQL_ROW]
		do
			across
				internal_connection.last_results as cursor
			from
				create Result.make (internal_connection.last_results.count)
			loop
				across
					cursor.item as res
				from
					create result_list.make (cursor.item.count)
				loop
					result_list.extend (create {PS_MYSQL_ROW}.make (res.item))
				end
				Result.extend (result_list.new_cursor)
			end
		end

	get_error: detachable PS_ERROR
			-- Translate the MySQL specific error code to an ABEL error object.
		local
			error_number: INTEGER
		do
				-- First try to define the error using SQLState
			Result := convert_error (internal_connection.last_sqlstate)

				-- Overwrite default SQLState for some errors
			error_number := internal_connection.last_server_error_number

			if error_number = 1205 then -- Lock timeout
				Result := transaction_aborted_error
				Result.set_backend_sqlstate (internal_connection.last_sqlstate)
			elseif error_number = 1064 then -- Syntax error
				Result := message_not_understood_error
				Result.set_backend_sqlstate (internal_connection.last_sqlstate)
			else
				fixme ("TODO: Check if more errors need manual handling")
			end

			if attached Result then
				Result.set_backend_error_message (internal_connection.last_error_message)
				Result.set_backend_error_code (error_number)
			end
		end

end
