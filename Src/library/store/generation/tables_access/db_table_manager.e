note
	description: "Database Manager using database structure description."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DB_TABLE_MANAGER

inherit
	ABSTRACT_DB_TABLE_MANAGER

create
	make

feature -- Initialization

	make (dbm: like database_manager)
			-- Set `dbm' to manage database
			-- interactions.
		require
			database_manager_not_void: dbm /= Void
		do
			database_manager := dbm
			create repository_table.make_filled (Void, 1, tables.Table_number)
			create update_parameters_table.make_filled (Void, 1, tables.Table_number)
			create updater_table.make_filled (Void, 1, tables.Table_number)
			select_query_prepared := True
			remove_order_by
		end

feature -- Connection

	set_connection_information (user_name, password, data_source: STRING)
			-- Set database connection information: `user_name', `password'
			-- and `data_source'.
		require
			not_void: user_name /= Void and password /= Void and data_source /= Void
		do
			database_manager.set_connection_information (user_name, password, data_source)
		end

	set_connection_string_information (a_connection_string: STRING_8)
			-- Set connection string required to connect to the database.
			-- It overrides the information set by `set_connection_information' when login.
		require
			not_void: a_connection_string /= Void
		do
			database_manager.set_connection_string_information (a_connection_string)
		end

	establish_connection
			-- Establish connection to database.
		do
			database_manager.establish_connection
		ensure
			not_void: session_control /= Void
		end

	disconnect
			-- Disconnect from database.
		require
			is_connected: is_connected
		do
			if attached database_manager.session_control as l_session_control then
				l_session_control.disconnect
			end
		end

feature -- Status report

	is_connected: BOOLEAN
			-- Is the application connected to a database?
		do
			if attached database_manager.session_control as l_session_control then
				Result := l_session_control.is_connected
			end
		end

	has_error: BOOLEAN
			-- Has an error occurred during last database operation?

	error_message: detachable STRING
			-- Error message if an error occurred during last
			-- database operation.
		obsolete
			"Use `error_message_32` instead  [2017-11-30]."
		do
			if attached error_message_32 as l_s then
				Result := l_s.as_string_8
			end
		end

	error_message_32: detachable STRING_32
			-- Error message if an error occurred during last
			-- database operation.

	select_query_prepared: BOOLEAN
			-- Is a select query prepared?

	is_id_selection: BOOLEAN
			-- Is prepared select query qualified with ID?

	like_type (type: INTEGER): BOOLEAN
			-- Does `type' require a SQL query using 'like'?
		do
			Result := type >= Prefix_type and then type <= Max_type
		end

	has_id (tablerow: DB_TABLE): BOOLEAN
			-- Does `tablerow' have an ID and can it be found?
		local
			td: DB_TABLE_DESCRIPTION
		do
			td := tablerow.table_description
			Result := td.Id_code /= td.No_id
		end

feature -- Access

	select_query: STRING
			-- Select query to execute. Execute with `load_result_list'.
		obsolete
			"Use `select_query_32` instead  [2020-05-31]."
		require
			select_query_prepared: select_query_prepared
		local
			q: like select_query_32
		do
			q := select_query_32
			if q.is_valid_as_string_8 then
				Result := q.to_string_8
			else
				Result := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (q)
			end
		end

	select_query_32: STRING_32
			-- Select query to execute. Execute with `load_result_list'.
		require
			select_query_prepared: select_query_prepared
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				Result := {STRING_32} "select "
				if attached select_columns as l_select_columns then
					Result.append (l_select_columns)
				else
					Result.append_character ('*')
				end
				Result.append_string_general (" from ")
				Result.append_string_general (l_select_table_descr.Table_name)
				if attached select_qualifiers as l_select_qualifiers then
					Result.append_string_general (" where ")
					Result.append (l_select_qualifiers)
				end
				Result.append (order_by)
			end
		end

	select_qualifiers: detachable STRING_32
			-- Qualifying clause of current SQL query.

	database_result_list: detachable ARRAYED_LIST [DB_TABLE]
			-- Database result list.
		do
			Result := result_list
		end

	database_result: detachable DB_TABLE
			-- Database unique result. Selection should
			-- have been qualified with ID.
		require
			no_error: not has_error
			is_id_selection: is_id_selection
		do
			if attached result_list as l_result_list and then not l_result_list.is_empty then
				Result := l_result_list.first
			end
		end

	select_table_descr: detachable DB_TABLE_DESCRIPTION
			-- Table description of select query to execute. Execute with `load_result_list'.

feature -- Basic operations

	load_result
			-- Load result. Set `has_error'. Result is available in
			-- `database_result' if result is unique, `database_result_list' otherwise.
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				result_list := load_list_with_query_and_tablecode (select_query_32, l_select_table_descr.Table_code)
			end
		end

	prepare_select_with_table (tablecode: INTEGER)
			-- Prepare a simple select query on table with code `tablecode'.
			-- Execute it with `load_result_list'.
		do
			select_query_prepared := True
			set_table (tablecode)
			set_all_columns
			remove_qualifiers
			remove_order_by
		end

	set_table (tablecode: INTEGER)
			-- Set table with code `tablecode' as result table of prepared select query.
			-- Don't change other select query parameters.
		require
			select_query_prepared: select_query_prepared
			is_valid_code: is_valid_code (tablecode)
		do
			select_table_descr := tables.obj (tablecode).table_description
		end

	set_all_columns
			-- Select all columns for prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			select_columns := All_columns
		end

	set_columns (cols: ARRAYED_LIST [INTEGER])
			-- Set `cols' as result columns of prepared select query.
			-- Don't change other select query parameters.
		require
			select_query_prepared: select_query_prepared
		local
			l_select_columns: like select_columns
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				from
					cols.start
					l_select_columns := l_select_table_descr.description_list.i_th (cols.item)
					select_columns := l_select_columns
					cols.forth
				until
					cols.after
				loop
					l_select_columns.append (Values_separator)
					l_select_columns.append (l_select_table_descr.description_list.i_th (cols.item))
					cols.forth
				end
			end
		end

	add_value_qualifier (column: INTEGER; value: READABLE_STRING_GENERAL)
			-- Add qualifier `column' = `value' to prepared select query.
		local
			q: STRING_32
			sql_value: STRING_32
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				sql_value := string_format_32 (value)
				q := l_select_table_descr.description_list.i_th (column) + Space + "=" + Space + sql_value
				add_qualifier (q)
			end
		end

	add_specific_qualifier (column: INTEGER; value: READABLE_STRING_GENERAL; type: INTEGER; case_sens: BOOLEAN)
			-- Add qualifier `column' related to `value' with `type' and `case'.
			-- 'LIKE' predicates are implemented by both Oracle and ODBC with '%' and '_' wild
			-- card characters.
			-- Case sensitiveness can only be specified for Oracle. ODBC set case sensitiveness
			-- directly on database columns.
		local
			q: STRING_32
			attr, val: STRING_32
			coltype: INTEGER
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				attr := l_select_table_descr.description_list.i_th (column)
				create val.make_from_string_general (value)
				coltype := l_select_table_descr.type_list.i_th (column)
				if case_sens or else not database_handle_name.same_string (Oracle_handle_name) then
					q := attr.twin
				else
					if
						coltype = l_select_table_descr.string_type
						or else coltype = l_select_table_descr.character_type
					then
						q := to_lower_32 (attr)
						val.to_lower
					else
						create q.make_from_string_general (attr)
					end
				end
				if like_type (type) then
						-- '%' and '_' have a special meaning in SQL (wild cards: '%' -> '*',
						-- '_' -> '?'): a solution is to replace
						-- these characters by any character, i.e. '_'.
					val.replace_substring_all (any_wildcard, only_one_wildcard)
					q.append (Space)
					q.append (Like_predicate)
					q.append (Space)
					if type = Contains_type or else type = Suffix_type then
						val.prepend (any_wildcard)
					end
					if type = Contains_type or else type = Prefix_type then
						val.append (any_wildcard)
					end
				else
					q.append (Space)
					if type = Equals_type then
						q.append_character ('=')
					elseif type = Greater_type then
						q.append_character ('>')
					elseif type = Lower_type then
						q.append_character ('<')
					end
					q.append (Space)
				end
					-- Gives a valid SQL string representation to `val'.
				if
					like_type (type)
					or else coltype = l_select_table_descr.string_type
					or else coltype = l_select_table_descr.character_type
				then
					val := string_format_32 (val)
				end
				q.append (val)
				add_qualifier (q)
			end
		end

	set_id_qualifier (id_value: STRING)
			-- Prepared select query will select table row with id `id_value'.
		require
			has_id: attached select_table_descr as lr_table_descr and then lr_table_descr.id_code /= lr_table_descr.No_id
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				remove_qualifiers
				add_value_qualifier (l_select_table_descr.Id_code, id_value)
				is_id_selection := True
			end
		ensure
			is_id_selection: is_id_selection
		end

	add_qualifier (value: READABLE_STRING_GENERAL)
			-- Add qualifier `value' to prepared select query.
		require
			select_query_prepared: select_query_prepared
			value_not_void: value /= Void
		do
			if attached select_qualifiers as l_select_qualifiers then
				l_select_qualifiers.append (Space)
				l_select_qualifiers.append (And_operator)
				l_select_qualifiers.append (Space)
				l_select_qualifiers.append_string_general (value)
			else
				create select_qualifiers.make_from_string_general (value)
			end
		end

	remove_qualifiers
			-- Remove all qualifiers of prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			select_qualifiers := Void
			is_id_selection := False
		ensure
			is_not_id_selection: not is_id_selection
		end

	set_order_by (column: INTEGER)
			-- Order result by attribute of code `column'.
		require
			select_query_prepared: select_query_prepared
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				order_by := Space + Order_by_clause + Space + l_select_table_descr.description_list.i_th (column)
			end
		end

	set_multiple_order_by (column_list: ARRAYED_LIST [INTEGER])
			-- Order result by attribute of code `column'.
		require
			select_query_prepared: select_query_prepared
			column_list_not_void: column_list /= Void
		local
			descr_list: ARRAYED_LIST [STRING_32]
		do
				-- implied by precondition `select_query_prepared'
			check attached select_table_descr as l_select_table_descr then
				descr_list := l_select_table_descr.description_list
				if not column_list.is_empty then
					order_by := Space + Order_by_clause + Space + descr_list.i_th (column_list.first)
					from
						column_list.start
						column_list.forth
					until
						column_list.after
					loop
						order_by.append (Values_separator)
						order_by.append (descr_list.i_th (column_list.item))
						column_list.forth
					end
				else
					remove_order_by
				end
			end
		end

	remove_order_by
			-- Remove order by from current prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			order_by := {STRING_32} ""
		end

feature -- Queries

	load_data_with_select (s: READABLE_STRING_GENERAL): detachable ANY
			-- Load directly an integer value from the database.
		require
			meaningful_select: s /= Void
		local
			l_error_message: detachable STRING_32
		do
			Result := database_manager.load_data_with_select (s)
			if database_manager.has_error then
				has_error := True
				l_error_message := selection_failed (s).twin
				l_error_message.append_string (database_manager.error_message_32)
				error_message_32 := l_error_message
			else
				has_error := False
			end
		end

	load_list_with_query_and_tablecode (query: READABLE_STRING_GENERAL; tablecode: INTEGER): detachable ARRAYED_LIST [DB_TABLE]
			-- Load list of table rows from `query'. Table rows type is
			-- table of code `tablecode'.
		require
			query_not_void: query /= Void
			is_valid_code: is_valid_code (tablecode)
		local
			obj: DB_TABLE
		do
			obj := tables.obj (tablecode)
			has_error := False
			Result := database_manager.load_list_with_select (query, obj)
			if database_manager.has_error and then attached database_manager.error_message_32 as l_error_message then
				has_error := True
				error_message_32 := selection_failed (query) + l_error_message
			end
		end

feature -- General command

	execute_query (query: READABLE_STRING_32)
			-- Execute SQL `query' and commit changes.
		require
			not_void: query /= Void
		local
			l_error_message: STRING_32
		do
			database_manager.execute_query (query)
			if database_manager.has_error then
				has_error := True
				l_error_message := command_failed.twin
				l_error_message.append_string (database_manager.error_message_32)
				error_message_32 := l_error_message
			end
		end

feature -- Update

	update_tablerow (tablerow: DB_TABLE)
			-- Update item with `description' in database.
		local
			table_descr: DB_TABLE_DESCRIPTION
			rescued: BOOLEAN
			updater: DB_CHANGE
		do
			if not rescued then
				if attached session_control as l_session_control then
					has_error := False
					l_session_control.reset
					table_descr := tablerow.table_description
					if attached updater_table.item (table_descr.Table_code) as l_table then
						updater := l_table
					else
						create updater.make
						updater.set_query (update_sql_query (table_descr))
					end
					map_parameters (updater, table_descr)
					updater.execute_query
					updater.clear_all
					commit
					if database_manager.has_error then
						has_error := True
						if attached database_manager.error_message_32 as l_error_message then
							error_message_32 := Update_failed + l_error_message
						else
							error_message_32 := Update_failed
						end
					end
				else
					has_error := True
					error_message_32 := update_failed + "No session created"
				end
			else
				has_error := True
				error_message_32 := Update_failed + Unexpected_error
			end
		rescue
			rescued := True
			retry
		end

feature -- Creation

	new_id_for_tablerow (table_descr: DB_TABLE_DESCRIPTION): detachable ANY
			-- Next available ID for table described by `table_descr'.
		require
			not_void: table_descr /= Void
			has_id: table_descr.id_code /= table_descr.No_id
		local
			res: detachable ANY
			type_code: INTEGER
		do
			type_code := table_descr.type_list.i_th (table_descr.id_code)
			res := load_data_with_select (max_id_query (table_descr))
			if type_code = table_descr.Date_time_type then
				Result := create {DATE_TIME}.make_now
			else
				if attached {DOUBLE_REF} res as double_ref then
					Result := double_ref.item + 1
				elseif attached {INTEGER_REF} res as integer_ref then
					Result := integer_ref.item + 1
				elseif attached {REAL_REF} res as real_ref then
					Result := real_ref.item + 1
				elseif type_code = table_descr.Double_type or type_code = table_descr.real_type then
					Result := 1.0
				elseif type_code = table_descr.Integer_type then
					Result := 1
				else
					has_error := True
					error_message_32 := id_creation_failed (table_descr.Table_name)
				end
			end
		ensure
			result_not_void: not has_error implies Result /= Void
		end

	set_id_and_create_tablerow, create_item_with_id (an_obj: DB_TABLE)
			-- Store in the DB object `an_obj' after giving it
			-- a valid ID.
		local
			table_descr: DB_TABLE_DESCRIPTION
			l_id: detachable ANY
		do
			table_descr := an_obj.table_description
			l_id := new_id_for_tablerow (table_descr)
			if l_id /= Void then
				table_descr.set_id (l_id)
				create_item_with_tablecode (an_obj, table_descr.table_code)
			else
					-- It should not happen per-precondition
				check not_has_id: False end
			end
		end

	create_item (an_obj: DB_TABLE)
			-- Store in the DB object `an_obj'.
		do
			create_item_with_tablecode (an_obj, an_obj.table_description.table_code)
		end

feature -- Deletion

	delete_item (an_obj: DB_TABLE)
			-- Delete `an_obj' in the database, i.e.
			-- the table row of `an_obj' table with `an_obj' ID.
		do
			delete_item_with_description (an_obj.table_description)
		end

	delete_tablerow (an_obj: DB_TABLE)
			-- Delete `an_obj' in the database,
			-- i.e. the table row of `an_obj' table with `an_obj' ID.
			--| Warning: delete all dependent table rows.
		local
			table_descr: DB_TABLE_DESCRIPTION
			ind, fkey, item: INTEGER
			deletion_fkey_value: ANY
			to_delete_tables: ARRAY [INTEGER]
			del_fkey_from_table: HASH_TABLE [INTEGER, INTEGER]
		do
			table_descr := an_obj.table_description
			del_fkey_from_table := table_descr.to_delete_fkey_from_table
			to_delete_tables := del_fkey_from_table.current_keys
			deletion_fkey_value := table_descr.id
			from
				ind := 1
			until
				ind > del_fkey_from_table.count --?fixme? or else has_error
			loop
				item := to_delete_tables.item (ind)
				fkey := del_fkey_from_table.item (item)
				load_and_delete_tablerows (item, fkey, deletion_fkey_value)
				ind := ind + 1
			end
			delete_item_with_description (table_descr)
		end

feature -- Commitment

	commit
			-- Commit changes in the database.
		do
			database_manager.commit
		end

feature {NONE} -- Update implementation

	map_parameters (updater: DB_CHANGE; table_descr: DB_TABLE_DESCRIPTION)
			-- Parameters of the procedure call.
		require
			updater_not_void: updater /= Void
			table_description_not_void: table_descr /= Void
		local
			name_list: ARRAYED_LIST [STRING_32]
			i: INTEGER
		do
			name_list := update_parameters (table_descr.Table_code)
			from
				i := 1
			until
				i > name_list.count
			loop
				updater.set_map_name (table_descr.attribute_value (i), name_list.i_th (i))
				i := i + 1
			end
		end

	update_sql_query (td: DB_TABLE_DESCRIPTION): STRING_32
			-- SQL query corresponding to a database update.
		require
			not_void: td /= Void
			has_id: td.id_code /= td.No_id
		local
			code: INTEGER
			parameter_list: ARRAYED_LIST [STRING_32]
			attribute_list: ARRAYED_LIST [STRING_32]
			l_has_id,
			l_do_append: BOOLEAN
		do
			code := td.Table_code
			create Result.make (20)
			Result.append_string_general ("update ")
			Result.append (tables.name_list.i_th (code))
			Result.append_string_general (" set ")
			parameter_list := update_parameters (code)
			attribute_list := td.description_list
			l_has_id := td.id_code /= td.no_id
			check
				count_matches: parameter_list.count = attribute_list.count
			end
			from
				parameter_list.start
				attribute_list.start
			until
				parameter_list.after
			loop
					-- Do not insert the table primary key into the insert statement, this produces and sql error
				l_do_append := l_has_id and then parameter_list.index /= td.id_code
				if l_do_append then
					Result.append (attribute_list.item)
					Result.append_string_general (" = :")
					Result.append_string_general (parameter_list.item)
				end
				parameter_list.forth
				attribute_list.forth
				if l_do_append and then not parameter_list.after then
					Result.append (Values_separator)
				end
			end
			Result.append_string_general (" where ")
			Result.append_string (td.id_name_32)
			Result.append_string_general (" = :")
			Result.append_string (parameter (td.id_name_32))
		end

	update_parameters (code: INTEGER): ARRAYED_LIST [STRING_32]
			-- Parameters names for an update on table with `code'.
			-- Parameters contain the required ':' prefix to tell
			-- EiffelCommerce it is a parameter.
		require
			is_valid_code: is_valid_code (code)
		do
			if attached update_parameters_table.item (code) as l_parameters then
				Result := l_parameters
			else
				Result := tables.description (code).mapped_list (agent parameter)
				update_parameters_table.put (Result, code)
			end
		end

	parameter (s: STRING_32): STRING_32
			-- Prepend "N_" to `s'.
		require
			s_not_void: s /= Void
		do
			Result := {STRING_32} "N_" + s
		end

feature {NONE} -- Creation implementation

	create_item_with_tablecode (an_obj: DB_TABLE; tablecode: INTEGER)
			--Store in the DB object `an_obj'.
		local
			rep: DB_REPOSITORY
			l_error_message_2: detachable STRING_32
		do
			has_error := False
			rep := repository (tablecode)
			if database_manager.has_error or else not rep.exists then
				has_error := True
				l_error_message_2 := Creation_failed + repository_failed (tables.name_list.i_th (tablecode))
				error_message_32 := l_error_message_2
				if database_manager.has_error and then attached database_manager.error_message_32 as l_error_message then
					l_error_message_2.append (l_error_message)
				else
					l_error_message_2.append (No_repository)
				end
			else
				database_manager.insert_with_repository (an_obj, rep)
				if database_manager.has_error then
					has_error := True
					if attached database_manager.error_message_32 as l_error_message then
						error_message_32 := Creation_failed + l_error_message
					else
						error_message_32 := Creation_failed
					end
				end
			end
		end

	max_id_query (table_descr: DB_TABLE_DESCRIPTION): STRING_32
			-- Query to find maximum ID for table described by `table_descr'.
		require
			not_void: table_descr /= Void
			has_id: table_descr.id_code /= table_descr.No_id
		do
			Result := {STRING_32} "select max("
			Result.append_string (table_descr.id_name_32)
			Result.append_string_general (") from ")
			Result.append_string_general (table_descr.table_name)
		end

	repository (code: INTEGER): DB_REPOSITORY
			-- Repository corresponding to the database table with `code'.
			-- Note: loaded repository are cached in `repository_table'.
		require
			is_valid_code: is_valid_code (code)
		do
			check
				valid_index: repository_table.valid_index (code)
				-- `code' should be within bounds of the `repository_table'.
			end
			if attached repository_table.item (code) as l_repository then
				Result := l_repository
			else
				create Result.make (tables.name_list.i_th (code).as_upper)
				Result.load
				if not database_manager.has_error then
					repository_table.put (Result, code)
				end
			end
		end

feature {NONE} -- Deletion implementation

	delete_item_with_description (description: DB_TABLE_DESCRIPTION)
			-- Delete `an_obj' in the database, i.e.
			-- the table row of `an_obj' table with `an_obj' ID.
		local
			q: STRING_32
		do
			q := {STRING_32} "delete from "
			q.append_string_general (description.Table_name)
			q.append_string_general (" where ")
			q.append_string (description.id_name_32)
			q.append_string_general (" = ")
			q.append_string_general (description.printable_id)
			database_manager.execute_query (q)
			if database_manager.has_error then
				has_error := True
				error_message_32 :=
					if attached database_manager.error_message_32 as l_error_message then
						Deletion_failed + l_error_message
					else
						Deletion_failed
					end
			end
		end

	load_and_delete_tablerows (table_code, fkey_code: INTEGER; fkey_value: ANY)
			-- Load and delete rows of table with `tablecode' where foreign key with `fkey_code'
			-- equals `fkey_value'.
		do
			prepare_select_with_table (table_code)
			add_value_qualifier (fkey_code, fkey_value.out)
			load_result
			if
				not database_manager.has_error and then
				attached result_list as l_result_list
			then
				⟳ r: l_result_list ¦ delete_tablerow (r) ⟲
			end
		end

feature {NONE} -- Connection

	session_control: detachable DB_CONTROL
			-- Session control.
		do
			Result := database_manager.session_control
		end

	database_handle_name: STRING
			-- Database handle name.
		local
			l_handle_name: like db_handle_name
		do
			l_handle_name := db_handle_name
			if l_handle_name = Void then
				l_handle_name := database_manager.database_handle_name
				db_handle_name := l_handle_name
			end
			Result := l_handle_name
		end

	db_handle_name: detachable STRING
			-- Database handle name.

	Oracle_handle_name: STRING = "ORACLE"
			-- Oracle handle name.

	Odbc_handle_name: STRING = "ODBC"
			-- ODBC handle name.

	string_format (s: STRING): STRING
			-- String representation in SQL of `s'.
		require
			s_not_void: s /= Void
		do
			Result := database_manager.string_format (s)
		end

	string_format_32 (s: READABLE_STRING_GENERAL): STRING_32
			-- String representation in SQL of `s'.
		require
			s_not_void: s /= Void
		do
			Result := database_manager.string_format_32 (s)
		end

	database_manager: DATABASE_MANAGER [DATABASE]
			-- Database manager: manage every interaction
			-- with database.

feature {NONE} -- Query

	select_columns: detachable STRING_32
			-- Columns to select from a selection statement.

	order_by: STRING_32
			-- SQL 'order by' clause.

	result_list: detachable ARRAYED_LIST [DB_TABLE]
			-- Last executed query result list.

	repository_table: ARRAY [detachable DB_REPOSITORY]
			-- Table that stores loaded repository.

	update_parameters_table: ARRAY [detachable ARRAYED_LIST [STRING_32]]
			-- Table that stores parameters/map names for a database update.

	updater_table: ARRAY [detachable DB_CHANGE]
			-- Table that stores database table updaters.

feature {NONE} -- SQL query construction

	Only_one_wildcard: STRING_32 = "_"
			-- SQL representation of a wild card matching any character.

	Any_wildcard: STRING_32 = "%%"
			-- SQL representation of a wild card matching any number of characters,
			-- including none.

	Space: STRING_32 = " "
			-- Space separator in SQL queries.

	to_lower_32 (a_attribute: READABLE_STRING_32): STRING_32
			-- Oracle SQL representation of the value in lower case for `a_attribute'.
		require
			a_attribute_not_void: a_attribute /= Void
		do
			create Result.make (8 + a_attribute.count)
			Result.append ("lower (")
			Result.append (a_attribute)
			Result.append (")")
		end

	Like_predicate: STRING_32 = "like"
			-- SQL 'like' predicate (used to match expressions using wildcards).

	Order_by_clause: STRING_32 = "order by"
			-- SQL 'order by' clause.

	Values_separator: STRING_32 = ", "
			-- SQL value separator: for 'order by' clauses and columns to select.

	All_columns: STRING_32 = "*"
			-- SQL all columns sign.

	And_operator: STRING_32 = "and"
			-- SQL 'and' operator.

feature {NONE} -- Error messages

	selection_failed (query: READABLE_STRING_GENERAL): STRING_32
			-- Database selection failed.
		require
			query_not_void: query /= Void
		do
			Result := {STRING_32} "Database selection failed:%NSQL query was: "
				+ query.as_string_32 + {STRING_32} "%NDatabase message is: "
		end

	Command_failed: STRING_32
			-- Database command failed.
		do
			Result := {STRING_32} "Database command failed:%N"
		end

	Update_failed: STRING_32
			-- Database update failed.
		do
			Result := {STRING_32} "Database update failed:%N"
		end

	Creation_failed: STRING_32
			-- Database creation failed.
		do
			Result := {STRING_32} "Table row creation failed:%N"
		end

	Deletion_failed: STRING_32
			-- Database deletion failed.
		do
			Result := {STRING_32} "Table row deletion failed:%N"
		end

	id_creation_failed (name: STRING_32): STRING_32
			-- ID creation failed on table with `name'.
		require
			not_void: name /= Void
		do
			Result := {STRING_32} "Cannot find a valid ID for the table: "
				+ name + "%N"
		end

	repository_failed (name: STRING_32): STRING_32
			-- Description on table with `name' cannot be retrieved.
		require
			not_void: name /= Void
		do
			Result := {STRING_32} "Cannot retrieve description of table "
				+ name + {STRING_32} " :%N"
		end

	No_repository: STRING_32
			-- Reposioty does not exist.
		do
			Result := {STRING_32} "Repository does not exist.%N"
		end

	Unexpected_error: STRING_32
			-- Unexpected error.
		do
			Result := {STRING_32} "Unexpected error."
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
