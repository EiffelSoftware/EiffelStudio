indexing

	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

deferred class DB_PROC_I

feature -- Status report

	text: STRING is
			-- SQL statement attached to stored procedure
		deferred
		end

	arguments_name: ARRAY [STRING]
			-- Argument names of stored procedure

	arguments_type: ARRAY [ANY]
			-- Argument types of stored procedure

feature -- Basic operations

	load is
			-- Make result of stored procedure execution available.
		deferred
		end

	store (sql: STRING) is
			-- Store current procedure performing `sql' statement.
		deferred
		end
		
	execute (destination: DB_EXPRESSION) is
			-- Execute current procedure with `destination'
			-- as a DB_SELECTION or a DB_CHANGE object mapping
			-- entity values with procedure parameter names
			-- if any. 
		deferred
		end

	drop is
			-- Drop current procedure from server.
		deferred
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does current procedure exist in server?
		deferred
		end

	arguments_set: BOOLEAN is
			-- Have arguments been set?
		do
			Result := (arguments_name /= Void and arguments_type /= Void)
		ensure
			arguments_set: Result implies 
								(arguments_name /= Void and arguments_type /= Void)
		end

feature -- Element change

	change_name (new_name: STRING) is
			-- Change procedure name with `new_name'.
		deferred
		end
			
	set_arguments (args_name: like arguments_name;
			 			args_type: like arguments_type) is
			-- Set `arguments_name' and `arguments_type' 
			-- of current as a variable list of argument 
			-- names and a variable list of argument 
			-- types, respectively.
		require
			args_name_not_void: args_name /= Void
			args_type_not_void: args_type /= Void
			not_arguments_set: not arguments_set
		do
			arguments_name := args_name
			arguments_type := args_type
		ensure			
			arguments_set
			set_with_input_parameter1: arguments_name = args_name
			set_with_input_parameter2: arguments_type = args_type
		end

	set_no_arguments is
			-- No arguments for the current procedure.
		do
			arguments_type := Void
			arguments_name := Void
		ensure
			arguments_type_void: arguments_type = Void
			arguments_name_void: arguments_name = Void
			no_arguments: not arguments_set
		end

end -- class DB_PROC_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
