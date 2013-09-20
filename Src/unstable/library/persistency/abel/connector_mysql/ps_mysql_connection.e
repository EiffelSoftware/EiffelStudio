note
	description: "Wrapper for a connection to a MySQL database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_CONNECTION

inherit

	PS_SQL_CONNECTION

inherit {NONE}

	REFACTORING_HELPER

create {PS_MYSQL_DATABASE}
	make

feature {PS_EIFFELSTORE_EXPORT} -- Settings

	set_autocommit (flag: BOOLEAN)
			-- Enable or disable autocommit
		do
			internal_connection.set_flag_autocommit (flag)
			autocommit := flag
		ensure then
			correctly_set: autocommit = flag
		end

feature {PS_EIFFELSTORE_EXPORT}

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
		end

feature {NONE} -- Implementation

	get_error: PS_ERROR
			-- Translate the MySQL specific error code to an ABEL error object.
		local
			error_number: INTEGER
		do
			error_number := internal_connection.last_server_error_number
			if transaction_errors.has (error_number) then
				create {PS_TRANSACTION_CONFLICT} Result
			else
				fixme ("TODO: Extend this for all types of errors")
				create {PS_GENERAL_ERROR} Result.make (internal_connection.last_error_message)
			end
		end

	transaction_errors: ARRAY [INTEGER]
			-- All MySQL error codes that indicate a conflict between transactions
		once
			Result := <<1205 -- Lock timeout
				>>
		end

end
