indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: execute, immediate, prepare
	Product: EiffelStore
	Database: All_Bases

class DB_EXEC

creation -- Creation procedure

	make

feature {NONE} -- Initialization

	make is
			-- Create current instance
		do
			unset_immediate
		ensure
			execution_status: not immediate_execution
		end

feature -- Status report

	immediate_execution: BOOLEAN
			-- Is execution of SQL query immediate?

	is_tracing: BOOLEAN
			-- Is trace option for SQL queries on?

	trace_output: FILE is
			-- Trace destination file
		once
			Result := io.error
		ensure
 			destination_file_present: Result = io.error
		end

feature -- Status setting

	set_immediate is
			-- Set `immediate_execution' to `true'.
			-- Query will be executed with a
			-- `EXECUTE IMMEDIATE' SQL  statement
		do
			immediate_execution := true
		ensure
			execution_status: immediate_execution
		end

	unset_immediate is
			-- Set `immediate_execution' to `false'.
			-- Query will be executed with a
			-- `PREPARE' and `EXECUTE' SQL statement.
		do
			immediate_execution := False
		ensure
			execution_status: not immediate_execution
		end

	set_trace is
			-- Trace queries sent to database server.
		do
			is_tracing := true
		ensure
			trace_status: is_tracing
		end

	unset_trace is
			-- Do not trace queries sent to database server.
		do
			is_tracing := false
		ensure
			trace_status: not is_tracing
		end

end -- class DB_EXEC


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
