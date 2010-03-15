note

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: execute, immediate, prepare
	Product: EiffelStore
	Database: All_Bases

class DB_EXEC

create -- Creation procedure

	make

feature {NONE} -- Initialization

	make
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

	trace_output: FILE
			-- Trace destination file
		once
			Result := io.error
		ensure
 			destination_file_present: Result = io.error
		end

feature -- Status setting

	set_immediate
			-- Set `immediate_execution' to `true'.
			-- Query will be executed with a
			-- `EXECUTE IMMEDIATE' SQL  statement
		do
			immediate_execution := true
		ensure
			execution_status: immediate_execution
		end

	unset_immediate
			-- Set `immediate_execution' to `false'.
			-- Query will be executed with a
			-- `PREPARE' and `EXECUTE' SQL statement.
		do
			immediate_execution := False
		ensure
			execution_status: not immediate_execution
		end

	set_trace
			-- Trace queries sent to database server.
		do
			is_tracing := true
		ensure
			trace_status: is_tracing
		end

	unset_trace
			-- Do not trace queries sent to database server.
		do
			is_tracing := false
		ensure
			trace_status: not is_tracing
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_EXEC



