indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: execute, immediate, prepare
	Product: EiffelStore
	Database: All_Bases

class DB_EXEC_USE

inherit

	HANDLE_USE

feature -- Status report

	immediate_execution: BOOLEAN is
			-- Are requests immediately executed?
			-- (default is `no').
		do
			Result := handle.execution_type.immediate_execution
		end

	is_tracing: BOOLEAN is
			-- Is trace option for SQL queries on?
		do
			Result := handle.execution_type.is_tracing
		end

	trace_output: FILE is
			-- Trace destination file
		do
			Result := handle.execution_type.trace_output
		end

feature -- Status setting

	set_immediate is
			-- Set queries to be executed with a
			-- `EXECUTE IMMEDIATE' SQL  statement.
		do
			handle.execution_type.set_immediate
		ensure
			execution_status: immediate_execution
		end

	unset_immediate is
			-- Set queries to be executed with a
			-- `PREPARE' followed by a `EXECUTE' SQL statement.
		do
			handle.execution_type.unset_immediate
		ensure
			execution_status: not immediate_execution
		end

	set_trace is
			-- Trace queries sent to database server.
		do
			handle.execution_type.set_trace
		ensure
			trace_status: is_tracing
		end

	unset_trace is
			-- Do not trace queries sent to database server.
		do
			handle.execution_type.unset_trace
		ensure
			trace_status: not is_tracing
		end

end -- class DB_EXEC_USE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

