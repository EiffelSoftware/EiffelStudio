note
	description: "Objects that generate table constraints."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

-- Constraint generation for ODBC is not done yet: Access ODBC driver
-- doesn't implement required ODBC functions. This can be done using
-- following ODBC functions:
-- * SQLPrimaryKeys()
-- * SQLForeignKeys()
-- See ODBC Reference chapter 7 and pages 670 and 855.

class
	TABLE_CONSTRAINTS_GENERATOR

inherit
	WIZARD_PROJECT_MANAGER

create
	make

feature -- Initialization

	make (code: INTEGER)
			-- Initialize.
		do
			dbms_code := code
			create db_subset_selection.make (db_manager (dbms_code))
			db_subset_selection.set_object (create {USER_CONSTRAINTS}.make)
			db_subset_selection.set_extract_function (agent table_name_from_user_constraints)
		end

feature -- Status report

	repository_set: BOOLEAN
			-- Has a repository, i.e. a table description
			-- been set?
		do
			Result := table_name /= Void
		end

	scope_tables_set: BOOLEAN
			-- Are scope tables set?
		do
			Result := db_subset_selection.valid_values /= Void
		end

	generated: BOOLEAN
			-- Have constraint definitions been generated?

feature -- Access

	id_name: STRING
			-- Table primary key attribute name.
		require
			generated: generated
		do
			if is_oracle (dbms_code) then
				if id_constraint /= Void then
					Result := id_constraint.column_name
					Result.to_lower
					to_initcap (Result)
				else
					Result := No_id
				end
			else
				if odbc_id_constraint /= Void then
					Result := odbc_id_constraint.column_name
					Result.to_lower
					to_initcap (Result)
				else
					Result := No_id
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	to_create_htable: STRING
			-- Definition of hash table representing the
			-- list of associated necessary tables and the
			-- linking foreign keys.
		require
			generated: generated
		do
			Result := to_create_ht
		ensure
			result_not_void: Result /= Void
		end

	to_delete_htable: STRING
			-- Definition of hash table representing the
			-- list of tables depending on this one and their
			-- foreign key for this table.
		require
			generated: generated
		do
			Result := to_delete_ht
		ensure
			result_not_void: Result /= Void
		end

feature -- Basic operations

	set_repository (rep: DB_REPOSITORY)
			-- Set `rep' as repository to use to
			-- generate table constraints.
		require
			not_void: rep /= Void
		do
			table_name := rep.repository_name
			generated := False
		ensure
			repository_set: repository_set
			not_generated: not generated
		end

	set_scope_tables (s_scope_tables: ARRAYED_LIST [STRING])
			-- Set `rep_list' table names as tables seen by the table which
			-- constraints will be generated.
		require
			not_void: s_scope_tables /= Void
		do
			db_subset_selection.set_valid_values (s_scope_tables)
		ensure
			scope_tables_set: scope_tables_set
		end

	generate
			-- Generate table constraints description using
			-- repository.
		require
			repository_set: repository_set
			scope_tables_set: scope_tables_set
		do
			generate_to_create_ht
			generate_id_name
			generate_to_delete_ht
			generated := True
		ensure
			generated: generated
		end

feature {NONE} -- Implementation

	dbms_code: INTEGER
			-- Selected DBMS code.

	table_name: STRING
			-- Table name.

	scope_tables: ARRAYED_LIST [STRING]
			-- Names of tables seen by the table.

	constraint_information (constraint_id: STRING): USER_CONS_COLUMNS
			-- Constraint information of constraint with `constraint_id'.
			-- Returns `Void' if attribute concerned is not unique.
		local
			res_list: ARRAYED_LIST [USER_CONS_COLUMNS]
			q: STRING
		do
			if is_oracle (dbms_code) then
				create Result.make
				q := select_with_constraint_name (constraint_id)
				res_list := db_manager (dbms_code).load_list_with_select (q, Result)
				if res_list.count = 1 then
					Result := res_list.first
				else
					Result := Void
				end
			else

			end
		ensure
			coherent: Result /= Void implies constraint_id.is_equal (Result.constraint_name)
		end

	constraints_from_type_and_table (c_type, table: STRING): ARRAYED_LIST [USER_CONSTRAINTS]
			-- Constraint list matching `type' and `table'.
		do
			db_subset_selection.set_query (select_with_type_and_table (c_type, table))
			db_subset_selection.load_result
			Result := db_subset_selection.database_result_list
		end

	constraints_from_foreign_key_ref (ref_constraint_name: STRING): ARRAYED_LIST [USER_CONSTRAINTS]
			-- List of constraints referencing `ref_constraint_name'.
		do
			db_subset_selection.set_query (select_with_ref_constraint_name (ref_constraint_name))
			db_subset_selection.load_result
			Result := db_subset_selection.database_result_list
		end

	select_with_constraint_name (cons_name: STRING): STRING
			-- Select query on table USER_CONS_COLUMNS qualified
			-- by 'constraint_name'.
		do
			Result := "Select * from USER_CONS_COLUMNS where constraint_name = '"
					+ cons_name + "'"
		end

	select_with_type_and_table (c_type, table: STRING): STRING
			-- Select query on table USER_CONSTRAINTS qualified
			-- by 'constraint_type' and 'table_name'.
		do
			Result := "Select * from USER_CONSTRAINTS where table_name = '"
					+ table + "' and constraint_type = '" + c_type + "'"
		end

	select_with_ref_constraint_name (r_cons_name: STRING): STRING
			-- Select query on table USER_CONSTRAINTS qualified
			-- by 'r_constraint_name'.
		do
			Result := "Select * from USER_CONSTRAINTS where r_constraint_name = '"
					+ r_cons_name + "'"
		end

	Oracle_fkey_type: STRING = "R"
			-- Oracle type for a foreign key.

	Oracle_pkey_type: STRING = "P"
			-- Oracle type for a primary key.

	id_constraint: USER_CONS_COLUMNS
			-- Constraint description containing `id_name'.

	odbc_id_constraint: ODBC_CONS_COLUMN
			-- Constraint description containing `id_name'.

	to_create_ht: STRING
			-- `to_create_htable' implementation.

	to_delete_ht: STRING
			-- `to_delete_htable' implementation.

	generate_to_create_ht
			-- Generate description of `to_create_htable'.
		local
			cons_list: ARRAYED_LIST [USER_CONSTRAINTS]
			cons_descr: USER_CONS_COLUMNS
			fkey_n, table_n: STRING
			fk_list: ARRAYED_LIST [ODBC_FOREIGN_KEY_RESULT]
			fk, fkitem: ODBC_FOREIGN_KEY_RESULT
		do
			if is_oracle (dbms_code) then
				cons_list := constraints_from_type_and_table (Oracle_fkey_type, table_name)
				check
					Result_not_void: cons_list /= Void
				end
				to_create_ht := "create Result.make (" + cons_list.count.out + ")%N"
				from
					cons_list.start
				until
					cons_list.after
				loop
					cons_descr := constraint_information (cons_list.item.constraint_name)
					fkey_n := cons_descr.column_name
					fkey_n.to_lower
					to_initcap (fkey_n)
					to_create_ht.append ("%T%T%TResult.force (" + fkey_n)
					cons_descr := constraint_information (cons_list.item.r_constraint_name)
					table_n := cons_descr.table_name
					table_n.to_lower
					to_initcap (table_n)
					to_create_ht.append (", tables." + table_n + ")%N")
					cons_list.forth
				end
			else
				create fk.make
				fk_list := db_manager (dbms_code).load_list_with_select ("SqlForeignKeys (" + table_name + ")", fk)

				to_create_ht := "create Result.make (" + fk_list.count.out + ")%N"
				from
					fk_list.start
				until
					fk_list.after
				loop
					fkitem := fk_list.item
					fkey_n := fkitem.fkcolumn_name
					fkey_n.to_lower
					to_initcap (fkey_n)

					table_n := fkitem.pktable_name
					table_n.to_lower
					to_initcap (table_n)

					to_create_ht.append ("%T%T%TResult.force (" + fkey_n)
					to_create_ht.append (", tables." + table_n + ")%N")
					fk_list.forth
				end
			end
		end

	generate_id_name
			-- Generate `id_name'.
		local
			cons_list: ARRAYED_LIST [USER_CONSTRAINTS]
			pk_list: ARRAYED_LIST [ODBC_PRIMARY_KEY_RESULT]
			pk: ODBC_PRIMARY_KEY_RESULT
		do
				-- Assume that there is no ID constraint.
			id_constraint := Void
			if is_oracle (dbms_code) then
				cons_list := constraints_from_type_and_table (Oracle_pkey_type, table_name)
				check
					Result_not_void: cons_list /= Void
					Unique_result: cons_list.count <= 1
				end
				if not cons_list.is_empty then
					id_constraint := constraint_information (cons_list.first.constraint_name)
				end
			else
				create pk.make
				pk_list := db_manager (dbms_code).load_list_with_select ("SqlPrimaryKeys (" + table_name + ")", pk)
				check
					Result_not_void: pk_list /= Void
					Unique_result: pk_list.count <= 1
				end
				if not pk_list.is_empty then
					create odbc_id_constraint.make (pk_list.first.table_name, pk_list.first.column_name)
				end
			end
		end

	generate_to_delete_ht
			-- Generate description of `to_delete_htable'.
		local
			cons_list: ARRAYED_LIST [USER_CONSTRAINTS]
			cons_descr: USER_CONS_COLUMNS
			item: USER_CONSTRAINTS
			table_n, fkey_n: STRING
			fk_list: ARRAYED_LIST [ODBC_FOREIGN_KEY_RESULT]
			fk, fkitem: ODBC_FOREIGN_KEY_RESULT
		do
			if is_oracle (dbms_code) then
				if id_constraint /= Void then
					cons_list := constraints_from_foreign_key_ref (id_constraint.constraint_name)
					check
						Result_not_void: cons_list /= Void
					end
					to_delete_ht := "create Result.make (" + cons_list.count.out + ")%N"
					from
						cons_list.start
					until
						cons_list.after
					loop
						item := cons_list.item
						check
							Reference_constraint: item.constraint_type.is_equal (Oracle_fkey_type)
						end
						cons_descr := constraint_information (item.constraint_name)
						table_n := cons_descr.table_name
						table_n.to_lower
						fkey_n := cons_descr.column_name
						fkey_n.to_lower
						to_initcap (fkey_n)
						to_delete_ht.append ("%T%T%TResult.force (tables." + table_n
								+ "_description." + fkey_n)
						to_initcap (table_n)
						to_delete_ht.append (", tables." + table_n + ")%N")
						cons_list.forth
					end
				else
					to_delete_ht := "create Result.make (0)%N"
				end
			else
				if odbc_id_constraint /= Void then
					create fk.make
					fk_list := db_manager (dbms_code).load_list_with_select ("SqlForeignKeysPrimary (" + table_name + ")", fk)
					to_delete_ht := "create Result.make (" + fk_list.count.out + ")%N"
					from
						fk_list.start
					until
						fk_list.after
					loop
						fkitem := fk_list.item
						table_n := fkitem.fktable_name
						table_n.to_lower
						to_initcap (table_n)

						fkey_n := fkitem.fkcolumn_name
						fkey_n.to_lower
						to_initcap (fkey_n)

						to_delete_ht.append ("%T%T%TResult.force (tables." + table_n
								+ "_description." + fkey_n)
						to_delete_ht.append (", tables." + table_n + ")%N")
						fk_list.forth
					end
				else
					to_delete_ht := "create Result.make (0)%N"
				end
			end
		end

	No_id: STRING = "No_id"
			-- No ID value.

	to_initcap (string: STRING)
			-- Change lower case `string' to `string' with initial capital character.
		require
			not_void: string /= void
		local
			initial: CHARACTER
		do
			initial := string.item (1)
			initial := initial.upper
			string.put (initial, 1)
		end

	db_subset_selection: DB_SUBSET_SELECTION [USER_CONSTRAINTS, STRING]
			-- Tool to carry out database selection with a criterion constraint.

	table_name_from_user_constraints (uc: USER_CONSTRAINTS): STRING
			-- Extracts table name frmo user constraints.
		do
			Result := uc.table_name
			Result.to_upper
		end

invariant
	db_subset_selection_created: db_subset_selection /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TABLE_CONSTRAINTS_GENERATOR
