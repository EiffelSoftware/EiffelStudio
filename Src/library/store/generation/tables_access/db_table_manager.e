indexing
	description: "Database Manager using database structure description."
	date: "$Date$"
	revision: "$Revision$"

class
	DB_TABLE_MANAGER

inherit
	ABSTRACT_DB_TABLE_MANAGER

creation
	make

feature -- Initialization

	make (dbm: DATABASE_MANAGER [DATABASE]) is
			-- Set `dbm' to manage database
			-- interactions.
		require
			database_manager_not_void: dbm /= Void
		do
			database_manager := dbm
			create repository_table.make (1, tables.Table_number)
			create update_parameters_table.make (1, tables.Table_number)
			create updater_table.make (1, tables.Table_number)
		end

feature -- Connection

	set_connection_information (user_name, password, data_source: STRING) is
			-- Set database connection information: `user_name', `password'
			-- and `data_source'.
		require
			not_void: user_name /= Void and password /= Void and data_source /= Void
		do
			database_manager.set_connection_information (user_name, password, data_source)
		end

	establish_connection is
			-- Establish connection to database.
		do
			database_manager.establish_connection
		ensure
			not_void: session_control /= Void
		end

	disconnect is
			-- Disconnect from database.
		require
			is_connected: is_connected
		do
			session_control.disconnect
		end

feature -- Status report

	is_connected: BOOLEAN is
			-- Is the application connected to a database?
		do
			Result := session_control /= Void and then session_control.is_connected
		end

	has_error: BOOLEAN
			-- Has an error occured during last database operation?

	error_message: STRING
			-- Error message if an error occured during last
			-- database operation.

	select_query_prepared: BOOLEAN
			-- Is a select query prepared?

	is_id_selection: BOOLEAN
			-- Is prepared select query qualified with ID?

	like_type (type: INTEGER): BOOLEAN is
			-- Does `type' require a SQL query using 'like'?
		do
			Result := type >= Prefix_type and then type <= Max_type
		end

	has_id (tablerow: DB_TABLE): BOOLEAN is
			-- Does `tablerow' have an ID and can it be found?
		local
			td: DB_TABLE_DESCRIPTION
		do
			td := tablerow.table_description
			Result := td.Id_code /= td.No_id
		end

feature -- Access

	select_query: STRING is
			-- Select query to execute. Execute with `load_result_list'.
		require
			select_query_prepared: select_query_prepared
		do
			Result := "select " + select_columns + " from " + select_table_descr.Table_name
			if select_qualifiers /= Void then
				Result.append (" where " + select_qualifiers)
			end
			Result.append (order_by)
		end

	select_qualifiers: STRING
			-- Qualifying clause of current SQL query.

	database_result_list: ARRAYED_LIST [DB_TABLE] is
			-- Database result list.
		do
			Result := result_list
		end

	database_result: DB_TABLE is
			-- Database unique result. Selection should
			-- have been qualified with ID.
		require
			no_error: not has_error
			is_id_selection: is_id_selection
		do
			if not result_list.is_empty then
				Result := result_list.first
			end
		end

feature -- Basic operations

	load_result is
			-- Load result. Set `has_error'. Result is available in
			-- `database_result' if result is unique, `database_result_list' otherwise.
		do
			result_list := load_list_with_query_and_tablecode (select_query, select_table_descr.Table_code)
		end

	prepare_select_with_table (tablecode: INTEGER) is
			-- Prepare a simple select query on table with code `tablecode'.
			-- Execute it with `load_result_list'.
		do
			select_query_prepared := True
			set_table (tablecode)
			set_all_columns
			remove_qualifiers
			remove_order_by
		end

	set_table (tablecode: INTEGER) is
			-- Set table with code `tablecode' as result table of prepared select query.
			-- Don't change other select query parameters.
		require
			select_query_prepared: select_query_prepared
			is_valid_code: is_valid_code (tablecode)
		do
			select_table_descr := tables.obj (tablecode).table_description
		end

	set_all_columns is
			-- Select all columns for prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			select_columns := All_columns
		end

	set_columns (cols: ARRAYED_LIST [INTEGER]) is
			-- Set `cols' as result columns of prepared select query.
			-- Don't change other select query parameters.
		require
			select_query_prepared: select_query_prepared
		do
			from
				cols.start
				select_columns := select_table_descr.description_list.i_th (cols.item)
				cols.forth
			until
				cols.after
			loop
				select_columns.append (Values_separator + select_table_descr.description_list.i_th (cols.item))
				cols.forth
			end
		end

	add_value_qualifier (column: INTEGER; value: STRING) is
			-- Add qualifier `column' = `value' to prepared select query.
		local
			q: STRING
			sql_value: STRING
		do
			sql_value := string_format (value)
			q := select_table_descr.description_list.i_th (column) + Space + "=" + Space + sql_value
			add_qualifier (q)
		end

	add_specific_qualifier (column: INTEGER; value: STRING; type: INTEGER; case_sens: BOOLEAN) is
			-- Add qualifier `column' related to `value' with `type' and `case'.
			-- 'LIKE' predicates are implemented by both Oracle and ODBC with '%' and '_' wild
			-- card characters.
			-- Case sensitiveness can only be specified for Oracle. ODBC set case sensitiveness
			-- directly on database columns. 
		local
			q: STRING
			attr, val: STRING
			coltype: INTEGER
		do
			attr := select_table_descr.description_list.i_th (column)
			val := clone (value)
			coltype := select_table_descr.type_list.i_th (column)
			if case_sens or else not database_handle_name.is_equal (Oracle_handle_name) then
				q := clone (attr)
			else
				if coltype = select_table_descr.string_type or else
						coltype = select_table_descr.character_type then
					q := to_lower (attr)
					val.to_lower
				else
					q := clone (attr)
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
					q.append ("=")
				elseif type = Greater_type then
					q.append (">")
				elseif type = Lower_type then
					q.append ("<")
				end
				q.append (Space)
			end
					-- Gives a valid SQL string representation to `val'.
			if like_type (type) or else
					coltype = select_table_descr.string_type or else
					coltype = select_table_descr.character_type then
				val := string_format (val)
			end
			q.append (val)
			add_qualifier (q)
		end

	set_id_qualifier (id_value: STRING) is
			-- Prepared select query will select table row with id `id_value'.
		require
			has_id: select_table_descr.id_code /= select_table_descr.No_id
		do
			remove_qualifiers
			add_value_qualifier (select_table_descr.Id_code, id_value)
			is_id_selection := True
		ensure
			is_id_selection: is_id_selection
		end

	add_qualifier (value: STRING) is
			-- Add qualifier `value' to prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			if select_qualifiers = Void then
				select_qualifiers := clone (value)
			else
				select_qualifiers.append (Space + And_operator + Space + value)
			end
		end

	remove_qualifiers is
			-- Remove all qualifiers of prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			select_qualifiers := Void
			is_id_selection := False
		ensure
			is_not_id_selection: not is_id_selection
		end

	set_order_by (column: INTEGER) is
			-- Order result by attribute of code `column'.
		require
			select_query_prepared: select_query_prepared
		do
			order_by := Space + Order_by_clause + Space + select_table_descr.description_list.i_th (column)
		end

	set_multiple_order_by (column_list: ARRAYED_LIST [INTEGER]) is
			-- Order result by attribute of code `column'.
		require
			select_query_prepared: select_query_prepared
			column_list_not_void: column_list /= Void
		local
			descr_list: ARRAYED_LIST [STRING]
		do
			descr_list := select_table_descr.description_list
			if not column_list.is_empty then
				order_by := Space + Order_by_clause + Space + descr_list.i_th (column_list.first)
				from
					column_list.start
					column_list.forth
				until
					column_list.after
				loop
					order_by.append (Values_separator + descr_list.i_th (column_list.item))
					column_list.forth
				end
			else
				remove_order_by
			end
		end

	remove_order_by is
			-- Remove order by from current prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			order_by := ""
		end

feature -- Queries

	load_data_with_select (s: STRING): ANY is
			-- Load directly an integer value from the database.
		require
			meaningful_select: s /= Void
		do
			has_error := False
			Result := database_manager.load_data_with_select (s)
			if database_manager.has_error then
				has_error := True
				error_message := selection_failed (s) + database_manager.error_message
			end
		end

	load_list_with_query_and_tablecode (query: STRING; tablecode: INTEGER): ARRAYED_LIST [DB_TABLE] is
			-- Load list of table rows from `query'. Table rows type is
			-- table of code `tablecode'.
		require
			is_valid_code: is_valid_code (tablecode)
		local
			obj: DB_TABLE
		do
			obj := tables.obj (tablecode)
			has_error := False
			Result := database_manager.load_list_with_select (query, obj)
			if database_manager.has_error then
				has_error := True
				error_message := selection_failed (query) + database_manager.error_message
			end
		end

feature -- General command

	execute_query (query: STRING) is
			-- Execute SQL `query' and commit changes.
		require
			not_void: query /= Void
		do
			database_manager.execute_query (query)
			if database_manager.has_error then
				has_error := True
				error_message := Command_failed + database_manager.error_message
			end
		end

feature -- Update

	update_tablerow (tablerow: DB_TABLE) is
			-- Update item with `description' in database.
		local
			table_descr: DB_TABLE_DESCRIPTION
			rescued: BOOLEAN
			updater: DB_CHANGE
		do
			if not rescued then
				has_error := False
				session_control.reset
				table_descr := tablerow.table_description
				if updater_table.item (table_descr.Table_code) /= Void then
					updater := updater_table.item (table_descr.Table_code)
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
					error_message := Update_failed + database_manager.error_message
				end
			else
				has_error := True
				error_message := Update_failed + Unexpected_error
			end
		rescue
			rescued := True
			retry		
		end

feature -- Creation

	new_id_for_tablerow (table_descr: DB_TABLE_DESCRIPTION): ANY is
			-- Next available ID for table described by `table_descr'.
		require
			not_void: table_descr /= Void
			has_id: table_descr.id_code /= table_descr.No_id
		local
			res: ANY
			double_ref: DOUBLE_REF
			integer_ref: INTEGER_REF
			type_code: INTEGER
		do
			type_code := table_descr.type_list.i_th (table_descr.id_code)
			res := load_data_with_select (max_id_query (table_descr))
			if type_code = table_descr.Date_time_type then
				Result := create {DATE_TIME}.make_now
			else
				if type_code = table_descr.Double_type then
					double_ref ?= res
					if double_ref /= Void then
						Result := double_ref.item + 1
					else
						Result := 1.0
					end
				elseif type_code = table_descr.Integer_type then
					integer_ref ?= res
					if integer_ref /= Void then
						Result := integer_ref.item + 1
					else
						Result := 1
					end
				else
					has_error := True
					error_message := id_creation_failed (table_descr.Table_name)
				end
			end
		end

	set_id_and_create_tablerow, create_item_with_id (an_obj: DB_TABLE) is
			-- Store in the DB object `an_obj' after giving it
			-- a valid ID.
		local
			table_descr: DB_TABLE_DESCRIPTION
		do
			table_descr := an_obj.table_description
			table_descr.set_id (new_id_for_tablerow (table_descr))
			create_item_with_tablecode (an_obj, table_descr.table_code)
		end

	create_item (an_obj: DB_TABLE) is
			-- Store in the DB object `an_obj'.
		do
			create_item_with_tablecode (an_obj, an_obj.table_description.table_code)
		end

feature -- Deletion

	delete_item (an_obj: DB_TABLE) is
			-- Delete `an_obj' in the database, i.e.
			-- the table row of `an_obj' table with `an_obj' ID.
		local
			table_descr: DB_TABLE_DESCRIPTION
		do
			table_descr := an_obj.table_description			
			delete_item_with_description (table_descr)
		end 

	delete_tablerow (an_obj: DB_TABLE) is
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
				load_and_delete_tablerows (to_delete_tables.item (ind), fkey, deletion_fkey_value)
				ind := ind + 1
			end
			delete_item_with_description (table_descr)
		end 

feature -- Commitment

	commit is
			-- Commit changes in the database.
		do
			database_manager.commit
		end

feature {NONE} -- Update implementation

	map_parameters (updater: DB_CHANGE; table_descr: DB_TABLE_DESCRIPTION) is
			-- Parameters of the procedure call.
		require
			updater_not_void: updater /= Void
			table_description_not_void: table_descr /= Void
		local
			name_list: ARRAYED_LIST [STRING]
			i: INTEGER
		do
			name_list := update_parameters (table_descr.Table_code)
			from
				i := 1
			until
				i > name_list.count
			loop
				updater.set_map_name (table_descr.attribute (i), name_list.i_th (i))
				i := i + 1
			end
		end

	update_sql_query (td: DB_TABLE_DESCRIPTION): STRING is
			-- SQL query corresponding to a database update.
		require
			not_void: td /= Void
			has_id: td.id_code /= td.No_id
		local
			code: INTEGER
			parameter_list: ARRAYED_LIST [STRING]
			attribute_list: ARRAYED_LIST [STRING]
		do
			code := td.Table_code
			Result := "update " + tables.name_list.i_th (code) + " set "
			parameter_list := update_parameters (code)
			attribute_list := td.description_list
			check
				count_matches: parameter_list.count = attribute_list.count
			end
			from
				parameter_list.start
				attribute_list.start
			until
				parameter_list.after
			loop
				Result.append (attribute_list.item + " = :" + parameter_list.item)
				parameter_list.forth
				attribute_list.forth
				if not parameter_list.after then
					Result.append (Values_separator)
				end
			end
			Result.append (" where " + td.id_name + " = :" + parameter (td.id_name))
		end

	update_parameters (code: INTEGER): ARRAYED_LIST [STRING] is
			-- Parameters names for an update on table with `code'.
			-- Parameters contain the required ':' prefix to tell
			-- EiffelCommerce it is a parameter.
		require
			is_valid_code: is_valid_code (code)
		do
			if update_parameters_table.item (code) /= Void then
				Result := update_parameters_table.item (code)
			else
				Result := tables.description (code).mapped_list (~parameter)
				update_parameters_table.put (Result, code)
			end
		end

	parameter (s: STRING): STRING is
			-- Prepend "N_" to `s'.
		do
			Result := "N_" + s
		end

feature {NONE} -- Creation implementation

	create_item_with_tablecode (an_obj: DB_TABLE; tablecode: INTEGER) is
			--Store in the DB object `an_obj'.
		local
			rep: DB_REPOSITORY
		do
			has_error := False
			rep := repository (tablecode)
			if database_manager.has_error or else not rep.exists then
				has_error := True
				error_message := Creation_failed + repository_failed (tables.name_list.i_th (tablecode))
				if database_manager.has_error then
					error_message.append (database_manager.error_message)
				else
					error_message.append (No_repository)
				end
			else
				database_manager.insert_with_repository (an_obj, rep)
				if database_manager.has_error then
					has_error := True
					error_message := Creation_failed + database_manager.error_message
				end
			end
		end

	max_id_query (table_descr: DB_TABLE_DESCRIPTION): STRING is
			-- Query to find maximum ID for table described by `table_descr'.
		require
			not_void: table_descr /= Void
			has_id: table_descr.id_code /= table_descr.No_id
		do
			Result := "select max(" + table_descr.id_name
					+ ") from " + table_descr.table_name
		end

	repository (code: INTEGER): DB_REPOSITORY is
			-- Repository corresponding to the database table with `code'.
			-- Note: loaded repository are cached in `repository_table'.
		require
			is_valid_code: is_valid_code (code)
		local
			s_tmp: STRING
		do
			check
				valid_index: repository_table.valid_index (code)
				-- `code' should be within bounds of the `repository_table'.
			end
			if repository_table.item (code) /= Void then
				Result := repository_table.item (code)
			else
				s_tmp := clone (tables.name_list.i_th (code))
				s_tmp.to_upper
				create Result.make (s_tmp)
				Result.load
				if not database_manager.has_error then
					repository_table.put (Result, code)
				end
			end
		end

feature {NONE} -- Deletion implementation

	delete_item_with_description (description: DB_TABLE_DESCRIPTION) is
			-- Delete `an_obj' in the database, i.e.
			-- the table row of `an_obj' table with `an_obj' ID.
		local
			q: STRING
		do
			q := "delete from " + description.Table_name + " where " + description.id_name
				+ " = " + description.printable_id
			database_manager.execute_query (q)
			if database_manager.has_error then
				has_error := True
				error_message := Deletion_failed + database_manager.error_message
			end
		end 

	load_and_delete_tablerows (table_code, fkey_code: INTEGER; fkey_value: ANY) is
			-- Load and delete rows of table with `tablecode' where foreign key with `fkey_code'
			-- equals `fkey_value'.
		do
			prepare_select_with_table (table_code)
			add_value_qualifier (fkey_code, fkey_value.out)
			load_result
			if not database_manager.has_error then
				if result_list /= Void then
					from
						result_list.start
					until
						result_list.after
					loop
						delete_tablerow (result_list.item)
						result_list.forth
					end
				end
			end
		end

feature {NONE} -- Implementation

	session_control: DB_CONTROL is
			-- Session control.
		once
			Result := database_manager.session_control
		end

	database_handle_name: STRING is
			-- Database handle name.
		do
			if db_handle_name = Void then
				db_handle_name := database_manager.database_handle_name
			end
			Result := db_handle_name
		end

	db_handle_name: STRING
			-- Database handle name.

	Oracle_handle_name: STRING is "ORACLE"
			-- Oracle handle name.

	Odbc_handle_name: STRING is "ODBC"
			-- ODBC handle name.

	string_format (s: STRING): STRING is
			-- String representation in SQL of `s'.
		do
			Result := database_manager.string_format (s)
		end

	database_manager: DATABASE_MANAGER [DATABASE]
			-- Database manager: manage every interaction
			-- with database.

feature {NONE} -- Implementation

	select_table_descr: DB_TABLE_DESCRIPTION
			-- Table description of select query to execute. Execute with `load_result_list'.

	select_columns: STRING
			-- Columns to select from a selection statement.

	order_by: STRING
			-- SQL 'order by' clause.

	result_list: ARRAYED_LIST [DB_TABLE]
			-- Last executed query result list.

	repository_table: ARRAY [DB_REPOSITORY]
			-- Table that stores loaded repository.

	update_parameters_table: ARRAY [ARRAYED_LIST [STRING]]
			-- Table that stores parameters/map names for a database update.

	updater_table: ARRAY [DB_CHANGE]
			-- Table that stores database table updaters.

feature {NONE} -- SQL query construction

	Only_one_wildcard: STRING is "_"
			-- SQL representation of a wild card matching any character.

	Any_wildcard: STRING is "%%"
			-- SQL representation of a wild card matching any number of characters,
			-- including none.

	Space: STRING is " "
			-- Space separator in SQL queries.

	to_lower (attribute: STRING): STRING is
			-- Oracle SQL representation of the value in lower case for `attribute'.
		do
			Result := "lower (" + attribute + ")"
		end

	Like_predicate: STRING is "like"
			-- SQL 'like' predicate (used to match expressions using wildcards).

	Order_by_clause: STRING is "order by"
			-- SQL 'order by' clause.

	Values_separator: STRING is ", "
			-- SQL value separator: for 'order by' clauses and columns to select.

	All_columns: STRING is "*"
			-- SQL all columns sign.

	And_operator: STRING is "and"
			-- SQL 'and' operator.

feature {NONE} -- Error messages

	selection_failed (query: STRING): STRING is
			-- Database selection failed.
		do
			Result := "Database selection failed:%NSQL query was: "
					+ query + "%NDatabase message is: "
		end

	Command_failed: STRING is
			-- Database command failed.
		do
			Result := "Database command failed:%N"
		end

	Update_failed: STRING is
			-- Database update failed.
		do
			Result := "Database update failed:%N"
		end

	Creation_failed: STRING is
			-- Database creation failed.
		do
			Result := "Table row creation failed:%N"
		end

	Deletion_failed: STRING is
			-- Database deletion failed.
		do
			Result := "Table row deletion failed:%N"
		end

	id_creation_failed (name: STRING): STRING is
			-- ID creation failed on table with `name'.
		require
			not_void: name /= Void
		do
			Result := "Cannot find a valid ID for the table: "
				+ name + "%N"
		end

	repository_failed (name: STRING): STRING is
			-- Description on table with `name' cannot be retrieved.
		require
			not_void: name /= Void
		do
			Result := "Cannot retrieve description of table "
				+ name + " :%N"
		end

	No_repository: STRING is
			-- Reposioty does not exist.
		do
			Result := "Repository does not exist.%N"
		end

	Unexpected_error: STRING is
			-- Unexpected error.
		do
			Result := "Unexpected error."
		end

end -- class DATABASE_MANAGER

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
