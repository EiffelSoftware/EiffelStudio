
note
	description: "Implementation of DB_PROC"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_PROC [G -> DATABASE create default_create end]
inherit

	HANDLE_USE

	HANDLE_SPEC [G]

	GLOBAL_SETTINGS

create -- Creation procedure

	make

feature -- Initialization

	make
			-- If the database has row numbers
			-- initialize `row_number'
		do
			if db_spec.has_row_number then
				row_number := 0
			end
			create name.make_empty
		end

feature -- Status report

	text: STRING
			-- SQL statement attached to stored procedure
		obsolete
			"Use `text_32' instead [2017-11-30]."
		do
			Result := text_32.as_string_8
		end

	text_32: STRING_32
			-- SQL statement attached to stored procedure
		local
			tuple: DB_TUPLE
			seq: INTEGER
			l_cursor: detachable DB_RESULT
		do
			if db_spec.support_sql_of_proc then
					private_selection.set_map_name (name, "name")
				if db_spec.has_row_number then
					create Result.make(1024)
					from
						seq := 1
					until
						seq > row_number
					loop
						private_selection.set_map_name (seq , "seq")
						private_selection.query (Select_text (name))
						private_selection.load_result
						private_selection.unset_map_name ("seq")
						l_cursor := private_selection.cursor
						if l_cursor /= Void then
							create tuple.copy (l_cursor)
							if attached {READABLE_STRING_GENERAL} tuple.item (1) as row_text then
								Result.append_string_general (row_text)
							end
						end
						seq := seq + 1
					end

				else
					private_selection.query (Select_text (name))
					private_selection.load_result
					l_cursor := private_selection.cursor
					if l_cursor /= Void then
						create tuple.copy (l_cursor)
						if attached {READABLE_STRING_GENERAL} tuple.item (1) as l_item then
							Result := l_item.as_string_32
						else
							create Result.make_empty
						end
					else
						create Result.make_empty
					end
				end
				private_selection.unset_map_name ("name")
				private_selection.terminate
			else
				Result := db_spec.text_not_supported
			end
		end

	arguments_name: detachable ARRAY [STRING]
			-- Argument names of stored procedure
		obsolete
			"Use `arguments_name_32' instead  [2017-11-30]."
		local
			i, l_upper: INTEGER_32
		do
			if attached arguments_name_32 as l_args then
				create Result.make_filled (once "", l_args.lower, l_args.upper)
				from
					l_upper := l_args.upper
					i := l_args.lower
				until
					i > l_upper
				loop
					Result.put (l_args.item (i).as_string_8, i)
					i := i + 1
				end
			end
		end

	arguments_name_32: detachable ARRAY [STRING_32]
			-- Argument names of stored procedure

	arguments_type: detachable ARRAY [detachable ANY]
			-- Argument types of stored procedure

feature -- Basic operations

	load
			-- Make result of stored procedure execution available.
			-- Activate current stored procedure from server
			-- so that presence may be accurately tested using `exists'.
		do
			set_p_exists
		end

	store (sql: READABLE_STRING_GENERAL)
			-- Store current procedure performing `sql' statement.
		require else
			argument_not_void: sql /= Void
		local
			sql_temp: STRING_32
		do
			if db_spec.support_stored_proc then
				sql_temp := db_spec.sql_adapt_db_32 (sql.as_string_32)
				private_string.wipe_out
				private_string.append_string_general(db_spec.sql_creation)
				private_string.append(name)
				append_in_args_type (private_string)
				private_string.append_string_general (db_spec.sql_as)
				private_string.append (sql_temp)
				private_string.append_string_general (db_spec.sql_end)
				private_change.modify (private_string)
			else
				db_spec.store_proc_not_supported
			end
		end

	execute (destination: DB_EXPRESSION)
			-- Execute current procedure with `destination'
			-- as a DB_SELECTION or a DB_CHANGE object mapping
			-- entity values with procedure parameter names
			-- if any.
		require else
			argument_not_void: destination /= Void
		do
			if db_spec.support_proc then
				private_string.wipe_out
				private_string.append_string_general (db_spec.sql_execution)
				private_string.append (proc_name)
				append_in_args_value (private_string)
				private_string.append_string_general (db_spec.sql_after_exec)
				destination.set_query (private_string)
				destination.execute_query
			else
				db_spec.exec_proc_not_supported
			end
		end

	execute_string (destination: DB_EXPRESSION; sql: READABLE_STRING_GENERAL)
			-- Execute the procedure using the sql statement `sql'
		do
			private_string.wipe_out
			private_string.append (sql.as_string_32)
			destination.set_query (private_string)
			destination.execute_query
		end

	drop
			-- Drop current procedure from server.
		do
			if db_spec.support_drop_proc then
				private_string.wipe_out
				private_string.append_string_general ("drop procedure ")
				private_string.append (name)
				if (handle.execution_type.immediate_execution) then
					private_change.modify (private_string)
				else
						-- Does not work with Oracle.
	--				handle.execution_type.set_immediate
					private_change.modify (private_string)
	--				handle.execution_type.unset_immediate
				end
			else
				db_spec.drop_proc_not_supported
			end
		end

feature -- Status report

	exists: BOOLEAN
			-- Does current procedure exist in server?
		do
			Result := p_exists
		end

	arguments_set: BOOLEAN
			-- Have arguments been set?
		do
			Result := (arguments_name_32 /= Void and arguments_type /= Void)
		ensure
			arguments_set: Result implies
								(arguments_name_32 /= Void and arguments_type /= Void)
		end

feature -- Element change

	change_name (new_name: STRING)
			-- Change procedure name with `new_name'.
		do
			if db_spec.name_proc_lower then
				new_name.to_lower
			end
			name := new_name.as_string_32
		ensure then
			name_changed: name.same_string_general (new_name) or else name.same_string_general (new_name.as_lower)
		end

	set_arguments (args_name: attached like arguments_name;
			 			args_type: attached like arguments_type)
			-- Set `arguments_name' and `arguments_type'
			-- of current as a variable list of argument
			-- names and a variable list of argument
			-- types, respectively.
		obsolete
			"Use `set_arguments_32' instead  [2017-11-30]."
		require
			args_name_not_void: args_name /= Void
			args_type_not_void: args_type /= Void
			not_arguments_set: not arguments_set
		local
			l_args: like arguments_name_32
			i, l_upper: INTEGER
		do
			create l_args.make_filled (once {STRING_32} "", args_name.lower, args_name.upper)
			from
				l_upper := args_name.upper
				i := args_name.lower
			until
				i > l_upper
			loop
				l_args.put (args_name.item (i).as_string_32, i)
				i := i + 1
			end
			set_arguments_32 (l_args, args_type)
		ensure
			arguments_set
			set_with_input_parameter2: arguments_type = args_type
		end

	set_arguments_32 (args_name: attached like arguments_name_32;
			 			args_type: attached like arguments_type)
			-- Set `arguments_name_32' and `arguments_type'
			-- of current as a variable list of argument
			-- names and a variable list of argument
			-- types, respectively.
		require
			args_name_not_void: args_name /= Void
			args_type_not_void: args_type /= Void
			not_arguments_set: not arguments_set
		do
			arguments_name_32 := args_name
			arguments_type := args_type
		ensure
			arguments_set
			set_with_input_parameter1: arguments_name_32 = args_name
			set_with_input_parameter2: arguments_type = args_type
		end

	set_no_arguments
			-- No arguments for the current procedure.
		do
			arguments_type := Void
			arguments_name_32 := Void
		ensure
			arguments_type_void: arguments_type = Void
			arguments_name_void: arguments_name_32 = Void
			no_arguments: not arguments_set
		end

feature {NONE} -- Implementation

	set_p_exists
			-- Set `p_exists'.
		local
			tuple: DB_TUPLE
			l_cursor: detachable DB_RESULT
		do
			if db_spec.support_proc then
				private_selection.set_map_name (name, {STRING_32} "name")
				private_selection.query (Select_exists)
				private_selection.unset_map_name ({STRING_32} "name")
				p_exists := handle.status.found
				private_selection.load_result
				l_cursor := private_selection.cursor
				if l_cursor = Void then
					p_exists := False
				else
					create tuple.copy (l_cursor)
					if not tuple.is_empty then
						if attached {INTEGER_REF} tuple.item (1) as temp_int then
							p_exists := temp_int > 0
							if db_spec.has_row_number then
								row_number := temp_int.item
							end
						elseif attached {INTEGER_64_REF} tuple.item (1) as temp_int64 then
								-- MySQL returns an integer_64 for count(*).
							p_exists := temp_int64.item > 0
							if db_spec.has_row_number then
								row_number := temp_int64.item.as_integer_32
							end
						else
							if attached {DOUBLE_REF} tuple.item (1) as temp_dble then
								p_exists := temp_dble > 0.0
								if db_spec.has_row_number then
									row_number := temp_dble.item.truncated_to_integer
								end
							else
									-- Added for ODBC, should really be abstracted
								p_exists := attached {READABLE_STRING_GENERAL} tuple.item (3) as temp_string and then not temp_string.is_empty
							end
						end
					else
						p_exists := False
					end
				end
				private_selection.terminate
			end
		end

	p_exists: BOOLEAN
			-- Does procedure exist?
			-- Value is effective after `set_p_exists'
			-- execution.

	append_in_args_value (s: STRING_32)
			-- Append map variables name from `d' in `s'.
			-- Map variables are used for set input arguments.
		require
			s_not_void: s /= Void
		local
			i: INTEGER
		do
			if attached arguments_name_32 as l_arguments_name_32 then
				s.append_string_general (db_spec.map_var_before)
				from
					i := l_arguments_name_32.lower
				until
					i > l_arguments_name_32.upper
				loop
					if db_spec.proc_args then
						s.append_string_general (db_spec.map_var_between)
						s.append (l_arguments_name_32.item (i))
						s.append_string_general (" = ")
					end
					s.append (db_spec.map_var_name_32 (l_arguments_name_32.item (i)))
					i := i + 1
					if i <= l_arguments_name_32.upper then
						s.extend (',')
					end
				end
				s.append_string_general (db_spec.map_var_after)
			end
		ensure
			s_larger: s.count > old s.count
		end

	append_in_args_type (s: STRING_32)
			-- Append arguments type name in `s' if `argument_set', otherwise no arguments.
		require
			s_not_void: s /= Void
		local
			i: INTEGER
			l_all_types: DB_ALL_TYPES
			l_obj: ANY
		do
			if attached arguments_name_32 as l_arguments_name_32 and attached arguments_type as l_arguments_type then
				s.append_string_general (db_spec.map_var_before)
				from
					i := l_arguments_name_32.lower
					l_all_types := handle.all_types
				until
					i > l_arguments_name_32.upper
				loop
					s.append_string_general (db_spec.map_var_between)
					s.append (l_arguments_name_32.item (i))
					s.append_string_general (db_spec.map_var_between_2)
					l_obj := l_arguments_type.item (i)
					if attached {INTEGER_16_REF}l_obj then
						s.append_string_general (db_spec.sql_name_integer_16)
					elseif attached {INTEGER_64_REF}l_obj then
						s.append_string_general (db_spec.sql_name_integer_64)
					elseif attached {IMMUTABLE_STRING_8} l_obj then
						s.append_string_general (l_all_types.db_type (string_8_for_type).sql_name)
					elseif attached {IMMUTABLE_STRING_32} l_obj then
						s.append_string_general (l_all_types.db_type (string_32_for_type).sql_name)
					elseif is_decimal_used and then is_decimal_function.item ([l_obj]) then
						s.append_string_general (db_spec.sql_name_decimal)
						s.append_string_general (" (")
						s.append_string_general (default_decimal_presicion.out)
						s.append_string_general (", ")
						s.append_string_general (default_decimal_scale.out)
						s.append_string_general (")")
					elseif l_obj = Void then
							-- Argument type should not be Void.
					else
						if l_all_types.is_registered (l_obj) then
							s.append_string_general (l_all_types.db_type (l_obj).sql_name)
						else
							s.append_string_general (" Unknown type")
						end
					end
					i := i + 1
					if i <= l_arguments_name_32.upper then
						s.extend (',')
					end
				end
				s.append_string_general (db_spec.map_var_after)
			else
				s.append_string_general (db_spec.no_args)
			end
		ensure
			s_larger: s.count > old s.count
		end

	string_8_for_type: STRING_8 = ""
			-- STRING_8 object for registered type

	string_32_for_type: STRING_32 = ""
			-- STRING_32 object for registered type

feature {NONE} -- Status report

	row_number: INTEGER
			-- record the number of segments into which the stored
			-- procedure is divided by INGRES

	name: STRING_32
			-- Stored procedure name

	qualifier: detachable STRING_32
			-- the qualifier of the procedure

	owner: detachable STRING_32
			-- the owner of the procedure

	proc_name: STRING_32
			-- Name of the procedure
		local
			quoter: STRING_32
			sep: STRING_32
		do
			create Result.make (100)

			create quoter.make(1)
			create sep.make(1)
			quoter := db_spec.identifier_quoter
			sep := db_spec.qualifier_separator
			if (attached qualifier as l_qualifier and then l_qualifier.count > 0) then
				Result.append(quoter)
				Result.append(l_qualifier)
				Result.append(quoter)
			end
			if (attached owner as l_owner and then l_owner.count > 0) then
				Result.append(sep)
				Result.append(quoter)
				Result.append(l_owner)
				Result.append(quoter)
			end
			if ((attached owner as l_owner and then l_owner.count > 0) or (attached qualifier as l_qualifier and then l_qualifier.count > 0)) then
				Result.append_string_general(".")
			end
			Result.append(quoter)
			Result.append(name)
			Result.append(quoter)
		end

	private_selection: DB_SELECTION
			-- Shared local object
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	private_change: DB_CHANGE
			-- Shared local object
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	private_string: STRING_32
			-- Constant string
		once
			create Result.make (50)
		ensure
			result_not_void: Result /= Void
		end

	Select_text (a_proc_name: STRING_32): STRING_32
			-- SQL query to get procedure text.
		require
			a_proc_name_not_void: a_proc_name /= Void
		do
			Result := db_spec.select_text_32 (a_proc_name)
		end

	Select_exists: STRING_32
			-- SQL query to test procedure existing.
		do
			Result := db_spec.Select_exists_32 (name)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_PROC


