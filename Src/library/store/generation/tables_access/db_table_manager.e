indexing
	description: "DATABASE Manager"
	author: "Davids"
	date: "$Date$"
	revision: "$Revision$"

class 
	DB_TABLE_MANAGER

inherit
	DB_TABLES_ACCESS_USE

	ABSTRACT_DB_TABLE_MANAGER

creation
	make

feature -- Initialization

	make (dbm: DATABASE_MANAGER [DATABASE]) is
			-- Create and set `dbm' to manage database
			-- interactions.
		require
			database_manager_not_void: dbm /= Void
		do
			database_manager := dbm
		end

feature -- Connection

	set_connection_information (a_name, a_psswd, data_source: STRING) is
			-- Try to connect the database
		require
			not_void: a_name /= Void and a_psswd /= Void
		do
			database_manager.set_connection_information (a_name, a_psswd, data_source)
		end

	establish_connection is
			-- Establish Connection
		do
			database_manager.establish_connection
		ensure
			not_void: session_control /= Void
		end

	disconnect is
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

feature -- Status report

	select_query_prepared: BOOLEAN
			-- Is a select query prepared?

	is_id_selection: BOOLEAN
			-- Is prepared select query qualified with ID?

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
			Result := result_list.first
		end

--	located_codes (tablecode, attributecode: INTEGER) is
--			-- Select codes available at `tablecode'/`attributecode' in table CODES.
--		require
--			is_valid_code: is_valid_code (tablecode)
--		local
--			codes_description: CODES_DESCRIPTION
--		do
--			codes_description := tables.codes_description
--			prepare_select_with_table (codes_description.Table_code)
--			add_value_qualifier (codes_description.Tablecode,
--						tablecode.out)
--			add_value_qualifier (codes_description.Attributecode,
--						attributecode.out)
--		end
--
--	codestring (tablecode, attributecode, codeinteger: INTEGER): STRING is
--			-- String code corresponding to `codeinteger' at
--			-- `tablecode'/`attributecode' in table CODES.
--		require
--			is_valid_code: is_valid_code (tablecode)
--		local
--			code_list: ARRAYED_LIST [CODES]
--			codes_description: CODES_DESCRIPTION
--		do
--			codes_description := tables.codes_description
--			located_codes (tablecode, attributecode)
--			add_value_qualifier (codes_description.Codeinteger,
--						codeinteger.out)
--			load_result
--			if not has_error then
--				code_list ?= database_result_list
--				if code_list /= Void and then code_list.count = 1 then
--					Result := code_list.first.codestring
--				else
--					has_error := True
--					error_message := "Error in table CODES: no value for code "
--							+ codeinteger.out + " located in "
--							+ codes_description.Table_name + "/"
--							+ codes_description.description_list.i_th (attributecode)
--							+ "."
--					io.putstring (error_message)
--				end
--			end
--		end

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
			select_columns := "*"
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
				select_columns.append (", " + select_table_descr.description_list.i_th (cols.item))
				cols.forth
			end
		end

	add_value_qualifier (column: INTEGER; value: STRING) is
			-- Add qualifier `column' = `value' to prepared select query.
		local
			q: STRING
		do
			q := select_table_descr.description_list.i_th (column) + " = '" + value + "'"
			add_qualifier (q)
		end

	add_special_value_qualifier (column: INTEGER; value: STRING) is
			-- Add qualifier prefix(`column') = `value' to prepared select query.
			-- Qualifier is case insensitive.
		require
			select_query_prepared: select_query_prepared
			valid_value: not value.has ('_') and then not value.has ('%%')
		local
			q: STRING
		do
			value.to_lower
			q := "lower (" + select_table_descr.description_list.i_th (column) + ") like '" + value + "%%'"
			add_qualifier (q)
		end

	set_id_qualifier (id_value: STRING) is
			-- Prepared select query will select table row with id `id_value'.
		do
			remove_qualifiers
			add_value_qualifier (Id_code, id_value)
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
				select_qualifiers := value
			else
				select_qualifiers.append (" and " + value)
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
			order_by := " order by " + select_table_descr.description_list.i_th (column)
		end

	remove_order_by is
			-- Remove order by from current prepared select query.
		require
			select_query_prepared: select_query_prepared
		do
			order_by := ""
		end

feature {NONE} -- Implementation

	select_table_descr: DB_TABLE_DESCRIPTION
			-- Table description of select query to execute. Execute with `load_result_list'.

	select_columns: STRING

	select_qualifiers: STRING

	order_by: STRING

	result_list: ARRAYED_LIST [DB_TABLE]
			-- Last executed query result list.

feature -- Queries

	load_integer_with_select (s: STRING): INTEGER is
			-- Load directly an integer value from the database.
		require
			meaningful_select: s /= Void
		do
			Result := database_manager.load_integer_with_select (s)
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
			Result := database_manager.load_list_with_select (query, obj)
		end


feature -- Queries without result to load.

	build_updater is
			-- Build an updater to execute many update queries
		local
			rescued: BOOLEAN
		do
			if not rescued then
				session_control.begin
				create db_change.make
				updater_build := True
			else
				has_error := True
				error_message := "Failure preparing an update."
			end
		rescue
			rescued := TRUE
			retry
		end

	execute_query_from_updater (a_query: STRING) is
		require
			not_void: a_query /= Void
			updater_build: updater_build
		local
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				has_error := False
				db_change.set_query (a_query)
				db_change.execute_query				
			else
				has_error := True
				error_message := "Database query execution failure : " + s
			end
		rescue
			rescued := TRUE
			retry
		end

	commit_query is
			-- Commit updates in the database
		require
			updater_build: updater_build
		local
			rescued: BOOLEAN
		do
			if not rescued then
				session_control.commit		
			else
				has_error := True
				error_message := "Database commit failure."
			end
		rescue
			rescued := TRUE
			retry
		end

feature -- Update

	update_tablerow (description: DB_TABLE_DESCRIPTION) is
			-- Update item with `description' in database.
		local
			rescued: BOOLEAN
			pr: DB_PROC
			expr: DB_CHANGE
			proc_name: STRING
		do
			if not rescued then
				has_error := False
				proc_name := "UPDATE_" + description.Table_name
				create pr.make (proc_name)
				pr.load
				expr := parameters_from_tablerow (description)
				pr.set_arguments (description.new_parameter_list,
						description.attribute_list)
				pr.execute (expr)
				expr.clear_all
				session_control.commit
			else
				has_error := True
				error_message := "An error occured while executing the following procedure in the database: " + proc_name
						+ ".%NPlease keep this dialog open and contact your DBA."
			end
		rescue
			rescued := TRUE
			retry		
		end

	update_item (an_obj: DB_TABLE; proc_name: STRING) is
			-- Update item 'an_obj', thanks to loaded procedure
			-- whose name is 'proc_name'.
		require
			not_void: an_obj /= Void and proc_name /= Void
		local
			rescued: BOOLEAN
			pr: DB_PROC
			expr: DB_CHANGE
			table_descr: DB_TABLE_DESCRIPTION
		do
			if not rescued then
				create pr.make (proc_name)
				pr.load
				table_descr := an_obj.table_description
				expr := parameters_from_tablerow (table_descr)
				pr.set_arguments (table_descr.new_parameter_list,
						table_descr.attribute_list)
				pr.execute (expr)
				expr.clear_all
				session_control.commit
			else
				has_error := True
				error_message := "Database procedure execution failure: " + proc_name
			end
		rescue
			rescued := TRUE
			retry		
		end

feature {NONE} -- Update implementation

	parameters_from_tablerow (table_descr: DB_TABLE_DESCRIPTION): DB_CHANGE is
			-- Parameters of the procedure call.
		local
			name_list: ARRAYED_LIST [STRING]
			i: INTEGER
		do
			create Result.make
			name_list := table_descr.new_parameter_list
			from
				i := 1
			until
				i > name_list.count
			loop
				Result.set_map_name (table_descr.attribute (i), name_list.i_th (i))
				i := i + 1
			end
		end

feature -- Creation

	new_id_for_tablerow (table_descr: DB_TABLE_DESCRIPTION): INTEGER is
			-- Next available ID for table described by `table_descr'.
		require
			not_void: table_descr /= Void
		do		
			Result := load_integer_with_select (max_id_query (table_descr)) + 1
		ensure
			possible: Result > 0
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

feature -- Deletions

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
			ind, fkey: INTEGER
			deletion_fkey_value: INTEGER_REF
			to_delete_tables: ARRAY [INTEGER] 
			del_fkey_from_table: HASH_TABLE [INTEGER, INTEGER]
		do
			table_descr := an_obj.table_description
			del_fkey_from_table := table_descr.to_delete_fkey_from_table
			to_delete_tables := del_fkey_from_table.current_keys
			from
				ind := 1
			until
				ind > del_fkey_from_table.count --?fixme? or else has_error
			loop
				fkey := del_fkey_from_table.item (to_delete_tables.item (ind))
				deletion_fkey_value ?= table_descr.attribute (fkey)
				check
					deletion_fkey_value /= Void
				end
				load_and_delete_tablerows (to_delete_tables.item (ind), fkey, deletion_fkey_value.item)
				ind := ind + 1
			end
			delete_item_with_description (table_descr)
		end 

feature {NONE}-- Deletions

	delete_item_with_description (description: DB_TABLE_DESCRIPTION) is
			-- Delete `an_obj' in the database, i.e.
			-- the table row of `an_obj' table with `an_obj' ID.
		local
			q: STRING
		do
			q := "delete from " + description.Table_name + " where " + description.id_name
				+ " = " + description.printable_id
			database_manager.execute_query (q)
		end 

	load_and_delete_tablerows (table_code, fkey_code, fkey_value: INTEGER) is
			-- Load and delete rows of table with `tablecode' where foreign key with `fkey_code'
			-- equals `fkey_value'.
		do
			prepare_select_with_table (table_code)
			add_value_qualifier (fkey_code, fkey_value.out)
			load_result
			if not has_error then
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

feature -- Status report

	updater_build: BOOLEAN
		-- Is an update query prepared?

feature {NONE} -- Implementation

	session_control: DB_CONTROL is
			-- Session Control
		do
			Result := database_manager.session_control
		end

	database_manager: DATABASE_MANAGER [DATABASE]
			-- Database manager: manage every interaction
			-- with database.

	Id_code: INTEGER is 1

	db_change: DB_CHANGE

	create_item_with_tablecode (an_obj: DB_TABLE; tablecode: INTEGER) is
			--	Store in the DB object `an_obj'.
		local
			rescued: BOOLEAN
			store_objects: DB_STORE
			rep: DB_REPOSITORY
		do
			if not rescued then
				has_error := False
				create store_objects.make
				rep := repository_list.i_th (tablecode)
				store_objects.set_repository (rep)
				store_objects.put (an_obj)	
				session_control.commit
			else
				has_error := True
				error_message := "An error occured while creating a table row in the database.%NTable%
						% name is " + an_obj.table_description.Table_name + ".%N"
			end
		rescue
			rescued := TRUE
			retry
		end

	max_id_query (table_descr: DB_TABLE_DESCRIPTION): STRING is
			-- Query to find maximum ID for table described by `table_descr'.
		require
			not_void: table_descr /= Void
		do
			Result := "select max(" + table_descr.id_name
					+ ") from " + table_descr.table_name
		end

	repository_list: ARRAYED_LIST [DB_REPOSITORY] is
			-- List of repositories corresponding to the database
			-- tables. Can be interpreted as a list
			-- or a hash-table.
		local
			rep: DB_REPOSITORY
			name_list: ARRAYED_LIST [STRING]
			s_tmp: STRING
		once
			create Result.make (tables.Table_number)
			name_list := tables.name_list
			from
				name_list.start
			until
				name_list.after
			loop
				s_tmp := clone (name_list.item)
				s_tmp.to_upper
				create rep.make (s_tmp)
				rep.load
				Result.extend (rep)
				name_list.forth
			end
		end


end -- class DATABASE_MANAGER
