note

	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
			-- Create an interface object to create
			-- and execute stored procedure.
		require
			a_name_not_void: a_name /= Void
			database_set: is_database_set
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

	text: STRING
			-- SQL text of current procedure
		obsolete
			"Use `text_32' instead  [2017-11-30]."
		require
			exists: exists
		do
			Result := implementation.text
		ensure
			result_not_void: Result /= Void
		end

	text_32: STRING_32
			-- SQL text of current procedure
		require
			exists: exists
		do
			Result := implementation.text_32
		ensure
			result_not_void: Result /= Void
		end

	arguments_name: detachable ARRAY [STRING]
			-- Argument names
		obsolete
			"Use `arguments_name_32' instead  [2017-11-30]."
		do
			Result := implementation.arguments_name
		end

	arguments_name_32: detachable ARRAY [STRING_32]
			-- Argument names
		do
			Result := implementation.arguments_name_32
		end

	arguments_type: detachable ARRAY [detachable ANY]
			-- Argument types
		do
			Result := implementation.arguments_type
		end

	loaded: BOOLEAN
			-- Is current procedure loaded?

	exists: BOOLEAN
			-- Does current procedure exist in server?
		require
			loaded: loaded
		do
			Result := implementation.exists
		end

	arguments_set: BOOLEAN
			-- Have arguments been set?
		do
			Result := (arguments_name_32 /= Void and
					arguments_type /= Void)
		ensure
			Result = (arguments_name_32 /= Void and
					arguments_type /= Void)
		end

feature -- Basic operations

	load
			-- Load stored procedure `name'
		require
			is_connected: is_connected
		do
			implementation.load
			loaded := True
			if not is_ok and then is_tracing then
				trace_message (error_message_32)
			end
		ensure
			loaded: loaded
		end

	store (sql: READABLE_STRING_GENERAL)
			-- Store current procedure with `sql' expression.
			--| Create an store procedure based on a valid `sql' expression.
			--| For example: sql = UPDATE Table_Name set Column_Name_1 = :N_Name_1, ...,Column_Name_n = :N_Name_n
			--| It will generate an store procedure like this
			--|
			--| create procedure update_name (N_NAME_1 DATABASE_TYPE_1, ...,N_NAME_N DATABASE_TYPE_N )
			--| BEGIN
			--|		update Table_Name set Column_Name_1 = :N_NAME_1,..., Colum_Name_n = :N_Name_n;
			--| END;
			--|
			--| How to use it?
			--|
			--| pr: DB_PROC; updater: DB_CHANGE; proc_name: STRING
			--|
			--| begin
			--|	create pr.make (proc_name)
			--|	create updater.make
			--|	updater.set_query (sql_query)
			--|  -- for each parameter to the store procedure call updater.set_map_name
			--|	pr.set_arguments (...)
			--|	pr.load
			--|	if not pr.exists then
			--|		pr.store (updater.last_query)
			--|		pr.load
			--|	end
			--|	pr.execute (updater)
			--|	updater.clear_all
			--|	commit
		require
			sql_not_void: sql /= Void
			not_exists: not exists
		do
			implementation.store (sql)
			if not is_ok and then is_tracing then
				trace_message (error_message_32)
			end
		end

	execute (destination: DB_EXPRESSION)
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
				trace_message (error_message_32)
			end
		end

	execute_string (destination: DB_EXPRESSION; sql: READABLE_STRING_GENERAL)
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
				trace_message (error_message_32)
			end
		end

	drop
			-- Drop current procedure from server.
		require
			exists: exists
		do
			implementation.drop
			if not is_ok and then is_tracing then
				trace_message (error_message_32)
			end
			loaded := False
		ensure
			not_loaded: not loaded
		end

feature -- Status setting

	change_name (new_name: like name)
			-- Change procedure name with `new_name'.
		require
			new_name_not_void: new_name /= Void
		do
			name := new_name.twin
			implementation.change_name (new_name)
			loaded := False
		ensure
			new_name.is_equal (name)
			not_loaded: not loaded
		end

	set_arguments (args_name: attached like arguments_name;
			args_type: attached like arguments_type)
			-- Set `arguments_name' of current
			-- as a variable list of argument names.
		obsolete
			"Use `set_arguments_32' instead  [2017-11-30]."
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

	set_arguments_32 (args_name: attached  like arguments_name_32;
			args_type: attached like arguments_type)
			-- Set `arguments_name_32' of current
			-- as a variable list of argument names.
		require
			args_name_not_void: args_name /= Void
			args_type_not_void: args_type /= Void
			same_count: args_name.count = args_type.count
		do
			implementation.set_arguments_32 (args_name, args_type)
		ensure
			arguments_name_32 = args_name
			arguments_type = args_type
			arguments_set
		end

	set_no_arguments
			-- No arguments for the current procedure
		do
			implementation.set_no_arguments
		ensure
			arguments_name_32 = Void
			arguments_type = Void
			no_arguments: not arguments_set
		end

feature {NONE} -- Implementation

	implementation: DATABASE_PROC [DATABASE]
		-- Handle reference to specific database implementation

invariant

	implementation_not_void: implementation /= Void
	load_and_exists: loaded implies (exists or not exists)

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DB_PROC
