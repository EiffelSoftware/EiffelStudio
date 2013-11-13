note
	description: "Wrapper for a connection to a MySQL database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_CONNECTION

inherit

	PS_SQL_CONNECTION
	PS_ABEL_EXPORT

--inherit {NONE}

	REFACTORING_HELPER
	PS_SQLSTATE_CONVERTER

create {PS_MYSQL_DATABASE}
	make

feature {PS_ABEL_EXPORT} -- Settings

	set_autocommit (flag: BOOLEAN)
			-- Enable or disable autocommit
		do
			internal_connection.set_flag_autocommit (flag)
			autocommit := flag
		ensure then
			correctly_set: autocommit = flag
		end

feature {PS_ABEL_EXPORT}

	execute_sql (statement: STRING)
			-- Execute the SQL statement `statement', and store the result (if any) in `Current.last_result'
			-- In case of an error, it will report it in `last_error' and raise an exception.
		do
			internal_connection.execute_query (statement)
			if internal_connection.has_error then
				print (statement)
				print (internal_connection.last_error_message)
				last_error := get_error
				last_error.raise
			end
			last_results := compute_last_results
		end

	commit
			-- Commit the currently active transaction.
			-- In case of an error, including a failed commit, it will report it in `last_error' and raise an exception.
		do
			internal_connection.commit
			if internal_connection.has_error then
				print (internal_connection.last_error_message)
				last_error := get_error
				last_error.raise
			end
		end

	rollback
			-- Rollback the currently active transaction.
			-- In case of an error, it will report it in `last_error' and raise an exception.
		do
			internal_connection.rollback
			if internal_connection.has_error then
				last_error := get_error
				last_error.raise
			end
		end

	last_result: ITERATION_CURSOR [PS_SQL_ROW]
			-- The result of the last database operation
		local
			result_list: LINKED_LIST [PS_SQL_ROW]
		do
			create result_list.make
			across
				internal_connection.last_result as res
			loop
				result_list.extend (create {PS_MYSQL_ROW}.make (res.item))
			end
			Result := result_list.new_cursor
		end

	last_results: LINKED_LIST[ITERATION_CURSOR[PS_SQL_ROW]]
			-- The results of the last database operations

	last_error: PS_ERROR
			-- The last occured error

feature {PS_MYSQL_DATABASE} -- Access

	internal_connection: MYSQLI_CLIENT
			-- The actual connection that gets wrapped here

feature {NONE} -- Initialization

	make (a_connection: MYSQLI_CLIENT; isolation_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Initialization for `Current'.
		do
			internal_connection := a_connection
			create {PS_NO_ERROR} last_error
			transaction_isolation_level := isolation_level
			create last_results.make
		end

feature {NONE} -- Implementation

	compute_last_results: LINKED_LIST[ITERATION_CURSOR[PS_SQL_ROW]]
			-- Get the last results as a linked list.
		local
			result_list: LINKED_LIST [PS_SQL_ROW]
		do
			across
				internal_connection.last_results as cursor
			from
				create Result.make
			loop
				across
					cursor.item as res
				from
					create result_list.make
				loop
					result_list.extend (create {PS_MYSQL_ROW}.make (res.item))
				end
				Result.extend (result_list.new_cursor)
			end
		end

	get_error: PS_ERROR
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

			Result.set_backend_error_message (internal_connection.last_error_message)
			Result.set_backend_error_code (error_number)
		end

end
