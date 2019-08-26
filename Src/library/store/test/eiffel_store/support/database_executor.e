note
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_EXECUTOR

inherit

	DB_SPECIFIC_TABLES_ACCESS_USE
	LOCALIZED_PRINTER

create
	make

feature -- Initialization

	make (a_connection: DATABASE_CONNECTION)
		do
			connection := a_connection
			create base_store.make
			create base_selection.make
			create users.make
			create update_parameters_table.make_filled (Void, 1, 1)
		end

feature -- Access

	repository: detachable DB_REPOSITORY

	connection: DATABASE_CONNECTION

	base_store: DB_STORE

	base_selection: DB_SELECTION

	users: NEW_USERS

	create_item (an_obj: DB_TABLE)
			-- Store in the DB object `an_obj'.
		do
			if not table_exists (an_obj.table_description.table_name) then
				io.putstring ("Table `"+ an_obj.table_description.table_name +"' does not exist...")
				io.put_new_line
				if attached repository as l_repository then
					l_repository.allocate (an_obj)
					l_repository.load
					io.putstring ("Table created.%N")
				end
			else
				io.putstring ("Table `"+ an_obj.table_description.table_name +"' already exisit.%N")
			end

			if attached repository as l_repository then
				connection.db_control.begin
				base_store.set_repository (l_repository)
				base_store.put (an_obj)
				if not connection.db_control.is_ok then
						-- The attempt to insert a new object
						-- failed
					localized_print (connection.db_control.error_message_32)
					io.new_line
					connection.db_control.rollback
				else
					io.putstring ("Object inserted%N")
					connection.db_control.commit
				end
			end

		end

feature -- Update

	update_tablerow (tablerow: DB_TABLE)
			-- Update item with `description' in database.
			-- Example code mapping Eiffel Commerce and
			-- how DB_PROC.store works.
		local
			description: DB_TABLE_DESCRIPTION
			rescued: BOOLEAN
			pr: DB_PROC
			updater: DB_CHANGE
			proc_name: STRING
		do

			proc_name := "UPDATE_"
			if not rescued then
				connection.db_control.reset
				connection.db_control.begin
				description := tablerow.table_description
				proc_name := "UPDATE_" + description.Table_name
				create pr.make (proc_name)
				create updater.make
				updater.set_query (update_sql_query (tablerow.table_description))
				map_parameters (updater, description)
				pr.set_arguments_32 (update_parameters (description.Table_code).to_array, description.attribute_list.to_array)
				pr.load
				if not pr.exists and then attached updater.last_query_32 as l_query then
					pr.store (l_query)
					pr.load
				end
				pr.execute (updater)
				updater.clear_all
				connection.db_control.commit
--				if updater.has_error then
--					has_error := True
--					error_message_32 := Update_failed + database_manager.error_message_32
--				end
			else
				io.put_string ( "An error occured while executing the following procedure in the database: " + proc_name + ".%N" )
			end
		rescue
			rescued := True
			retry
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
			Result := {STRING_32} "update "
			Result.append_string (tables.name_list.i_th (code))
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
					Result.append (parameter_list.item)
				end
				parameter_list.forth
				attribute_list.forth
				if l_do_append and then not parameter_list.after then
					Result.append (Values_separator)
				end
			end
			Result.append_string_general (" where ")
			Result.append (td.id_name_32)
			Result.append_string_general (" = :")
			Result.append (parameter (td.id_name_32))
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

	update_parameters_table: ARRAY [detachable ARRAYED_LIST [STRING_32]]
			-- Table that stores parameters/map names for a database update.

	parameter (s: STRING_32): STRING_32
			-- Prepend "N_" to `s'.
		require
			s_not_void: s /= Void
		do
			create Result.make (2 + s.count)
			Result.append_string ({STRING_32} "N_")
			Result.append (s)
		end

	Values_separator: STRING = ", "
			-- SQL value separator: for 'order by' clauses and columns to select.


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


feature {NONE} -- Implementation


	table_exists (table: STRING): BOOLEAN
			-- Does table `table' exist in the database?
		require
			connected: connection.is_connected
		local
			l_repository: like repository
		do
			-- Create and load the DB_REPOSITORY named 'table'
			create l_repository.make (table)
			repository := l_repository
			l_repository.load
			Result := l_repository.exists
		ensure
			repository_attached: attached repository as le_repository
			Result = le_repository.exists
		end

end
