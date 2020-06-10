note
	description: "Database handler Implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_HANDLER_IMPL

inherit
	DATABASE_HANDLER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a database handler with connnection `connection'.
		do
			connection := a_connection
			create last_query.make_now
			set_successful
		ensure
			connection_not_void: connection /= Void
			last_query_not_void: last_query /= Void
		end

feature -- Functionality

	execute_reader
			-- Execute stored procedure that returns data.
		local
			l_db_selection: DB_SELECTION
			l_retried: BOOLEAN
		do
			if not l_retried then
				if not keep_connection then
					connect
				end

				if attached store as l_store then
					create l_db_selection.make
					db_selection := l_db_selection
					items := l_store.execute_reader (l_db_selection)
				end

				if not keep_connection then
					disconnect
				end
				set_successful
				debug
					log.write_debug ( generator+".execute_reader Successful")
				end
			end
		rescue
			set_last_error_from_exception ("Store procedure execution")
			log.write_critical (generator+ ".execute_reader " + last_error_message.to_string_8)
			if is_connected then
				disconnect
			end
			l_retried := True
			retry
		end

	execute_writer
			-- Execute stored procedure that update/add data.
		local
			l_db_change: DB_CHANGE
			l_retried : BOOLEAN
		do
		    if not  l_retried then
				if not keep_connection and not is_connected then
					connect
				end

				if attached store as l_store then
					create l_db_change.make
					db_update := l_db_change
					l_store.execute_writer (l_db_change)
					if not l_store.has_error then
						db_control.commit
					end
				end
				if not keep_connection then
					disconnect
				end
				set_successful
				debug
					log.write_debug ( generator+".execute_writer Successful")
				end
			end
		rescue
			set_last_error_from_exception ("Store procedure execution")
			log.write_critical (generator+ ".execute_writer " + last_error_message.to_string_8)
			if is_connected then
				disconnect
			end
			l_retried := True
			retry
		end

feature -- SQL Queries

	execute_query
			-- Execute query.
		local
			l_db_selection: DB_SELECTION
			l_retried: BOOLEAN
		do
			if not l_retried then
				if not keep_connection then
					connect
				end

				if attached query as l_query then
					create l_db_selection.make
					db_selection := l_db_selection
					items := l_query.execute_reader (l_db_selection)
				end
				if not keep_connection then
					disconnect
				end
				set_successful
			end
		rescue
			set_last_error_from_exception ("execute_query")
			log.write_critical (generator+ ".execute_query " + last_error_message.to_string_8)
			if is_connected then
				disconnect
			end
			l_retried := True
			retry
		end


	execute_change
			-- Execute sqlquery that update/add data.
		local
			l_db_change: DB_CHANGE
			l_retried : BOOLEAN
		do
		    if not  l_retried then
				if not keep_connection and not is_connected then
					connect
				end

				if attached query as l_query then
					create l_db_change.make
					db_update := l_db_change
					l_query.execute_change (l_db_change)
					db_control.commit
				end
				if not keep_connection then
					disconnect
				end
				set_successful
			end
		rescue
			set_last_error_from_exception ("Store procedure execution")
			log.write_critical (generator+ ".execute_writer " + last_error_message.to_string_8)
			if is_connected then
				disconnect
			end
			l_retried := True
			retry
		end


feature -- Iteration

	start
			-- Set the cursor on first element.
		do
			if attached db_selection as l_db_selection and then l_db_selection.container /= Void then
				l_db_selection.start
			end
		end

	forth
			-- Move cursor to next element.
		do
			if attached db_selection as l_db_selection then
				l_db_selection.forth
			else
				check False end
			end
		end

	after: BOOLEAN
			-- True for the last element.
		do
			if attached db_selection as l_db_selection and then l_db_selection.container /= Void then
				Result := l_db_selection.after or else l_db_selection.cursor = Void
			else
				Result := True
			end
		end

	item: DB_TUPLE
			-- Current element.
		do
			if attached db_selection as l_db_selection and then attached l_db_selection.cursor as l_cursor then
				create {DB_TUPLE} Result.copy (l_cursor)
			else
				check False then end
			end
		end


feature {NONE} -- Implementation

	connection: DATABASE_CONNECTION
		-- Database connection.

	db_control: DB_CONTROL
		-- Database control.
		do
			Result := connection.db_control
		end

	db_result: detachable DB_RESULT
		-- Database query result.

	db_selection: detachable DB_SELECTION
		-- Database selection.

	db_update: detachable DB_CHANGE
		-- Database modification.	

	last_query: DATE_TIME
		-- Last time when a query was executed.

	keep_connection: BOOLEAN
		-- Keep connection alive?
		do
			Result := connection.keep_connection
		end

	connect
			-- Connect to the database.
		do
			if attached db_control as d and then not is_connected then
				d.connect
			end
		end

	disconnect
			-- Disconnect from the database.
		do
			if attached db_control as d then
				d.disconnect
			end
		end

	is_connected: BOOLEAN
			-- True if connected to the database.
		do
			Result := attached db_control as d and then d.is_connected
		end

	affected_row_count: INTEGER
			--  The number of rows changed, deleted, or inserted by the last statement.
		do
			if attached db_update as l_update then
				Result := l_update.affected_row_count
			end
		end

feature -- Result

	items : detachable LIST[DB_RESULT]
		-- Query result.

	count: INTEGER
			-- <Precursor>
		do
			if attached items as l_items then
				Result := l_items.count
			end
		end

end
