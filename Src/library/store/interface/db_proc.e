indexing

	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

class DB_PROC inherit

	DB_EXEC_USE

	DB_STATUS_USE
		export
			{ANY} is_ok
			{ANY} is_connected
		end

creation -- Creation procedure
	
	make

feature -- Initialization

	make (a_name: STRING) is
			-- Create an interface object to create 
			-- and execute stored procedure.
		require
			a_name_not_void: a_name /= Void
		do
			implementation := handle.database.db_proc
			implementation.change_name (a_name)
			name := a_name
		ensure
			name_equal: name.is_equal (a_name)
		end

feature -- Status report

	name: STRING
			-- Procedure name

	text: STRING is
			-- SQL text of current procedure
		require
			exists: exists
		do
			Result := implementation.text
		ensure
			result_not_void: Result /= Void
		end

	arguments_name: ARRAY [STRING] is
			-- Argument names
		do
			Result := implementation.arguments_name
		end

	arguments_type: ARRAY [ANY] is
			-- Argument types
		do
			Result := implementation.arguments_type
		end

	loaded: BOOLEAN
			-- Is current procedure loaded?

	exists: BOOLEAN is
			-- Does current procedure exist in server?
		require
			loaded: loaded
		do
			Result := implementation.exists
		end

	arguments_set: BOOLEAN is
			-- Have arguments been set?
		do
			Result := (arguments_name /= Void and
					arguments_type /= Void)
		ensure
			Result = (arguments_name /= Void and
					arguments_type /= Void)
		end

feature -- Basic operations

	load is
			-- Load stored procedure `name'
		require
			is_connected: is_connected
		do
			implementation.load
			loaded := True
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			loaded: loaded
		end

	store (sql: STRING) is
			-- Store current procedure with `sql' expression.
		require
			sql_not_void: sql /= Void
			not_exists: not exists
		do
			implementation.store (sql)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end
		
	execute (destination: DB_EXPRESSION) is
			-- Execute current procedure with `destination'
			-- be a DB_SELECTION or DB_CHANGE object mapping
			-- entity values with procedure parameter names
			-- if any.
		require
			destination_not_void: destination /= Void
			exists: exists
		do
			implementation.execute (destination)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end

	execute_string (destination: DB_EXPRESSION; sql: STRING) is
			-- Execute using `sql' statement current procedure with `destination'
			-- be a DB_SELECTION or DB_CHANGE object mapping
			-- entity values with procedure parameter names
			-- if any.
		require
			destination_not_void: destination /= Void
			exists: exists
		do
			implementation.execute_string (destination, sql)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end

	drop is
			-- Drop current procedure from server.
		require
			exists: exists
		do
			implementation.drop
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
			loaded := False
		ensure
			not_loaded: not loaded
		end

feature -- Status setting

	change_name (new_name: STRING) is
			-- Change procedure name with `new_name'.
		require
			new_name_not_void: new_name /= Void
		do
			name := clone (new_name)
			implementation.change_name (new_name)
			loaded := False
		ensure
			new_name.is_equal (name)
			not_loaded: not loaded
		end
			
	set_arguments (args_name: like arguments_name;
			args_type: like arguments_type) is
			-- Set `arguments_name' of current
			-- as a variable list of argument names.
		require
			args_name_not_void: args_name /= Void
			args_type_not_void: args_type /= Void
			same_count: args_name.count = args_type.count
		do
			implementation.set_arguments (args_name, args_type)
		ensure
			arguments_name = args_name
			arguments_type = args_type
			arguments_set
		end

	set_no_arguments is
			-- No arguments for the current procedure
		do
			implementation.set_no_arguments
		ensure
			arguments_name = Void
			arguments_type = Void
			no_arguments: not arguments_set
		end

feature {NONE} -- Implementation

	implementation: DATABASE_PROC [DATABASE]
		-- Handle reference to specific database implementation

invariant

	implementation_not_void: implementation /= Void
	load_and_exists: loaded implies (exists or not exists)

end -- class DB_PROC



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
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

