indexing
	description: "Implementation of DB_STORE";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_STORE [G -> DATABASE create default_create end]

inherit

	DB_STATUS_USE
		undefine
			is_equal, out, copy, consistent, setup
		end

	DB_EXEC_USE
		undefine
			is_equal, out, copy, consistent, setup
		end

	SQL_SCAN
		rename
			make as scan_make,
			put as string_put
		redefine
			start, next_index
		end

	HANDLE_SPEC [G]
		undefine
			is_equal, out, copy, consistent, setup
		end

creation -- Creation procedure

	make

feature -- Initialization

	make (size: INTEGER) is
		do
			!! ht.make (1)
			!! map_table.make (1, 10)
			scan_make (size)
		end

feature -- Status setting

	set_repository (one_repository: DATABASE_REPOSITORY[G]) is
			-- Associate `one_repository' handle to current
			-- db_store handle.
		require
			parameter_not_void: one_repository /= Void
		do
			repository := one_repository
		ensure then
			repository_not_void: repository /= Void
		end

feature -- Status report

	repository: DATABASE_REPOSITORY[G]
			-- Associated repository

	owns_repository: BOOLEAN is
			-- Is the current store operation associated
			-- with a repository?
		do
			Result := repository /= Void
		ensure
			existence_condition: Result = (repository /= Void)
		end

feature -- Basic operations

	put (object: ANY) is
			-- Store `object' into active repository.
		require
			object_exists: object /= Void
			owns_repository: owns_repository
			repository_exists: repository.exists
		local
			tmp_string: STRING
			temp_descriptor: INTEGER
			quoter: STRING
			sep: STRING
		do
			update_map_table (object)
			!!quoter.make(1)
			!!sep.make(1)
			quoter := db_spec.identifier_quoter
			sep := db_spec.qualifier_seperator
			sql_string.wipe_out
			sql_string.append ("INSERT INTO ")
			if (repository.rep_qualifier /= Void and then repository.rep_qualifier.count > 0) then
				sql_string.append(quoter)
				sql_string.append(repository.rep_qualifier)
				sql_string.append(quoter)
			end
			if (repository.rep_owner /= Void and then repository.rep_owner.count > 0) then
				sql_string.append(sep)
				sql_string.append(quoter)
				sql_string.append(repository.rep_owner)
				sql_string.append(quoter)
			end
			if ((repository.rep_owner /= Void and then repository.rep_owner.count > 0) or (repository.rep_qualifier /= Void and then repository.rep_qualifier.count > 0)) then
				sql_string.append(".")
			end
			sql_string.append(quoter)
			sql_string.append (repository.repository_name)
			sql_string.append(quoter)
			sql_string.append(db_spec.put_column_name(repository, map_table))
			sql_string.append (" VALUES ( :XZ7Hj0sb5UU )")
			set_map_name (object, "XZ7Hj0sb5UU")
			tmp_string := parse (sql_string)
			unset_map_name ("XZ7Hj0sb5UU")
			if tmp_string /= Void then
				temp_descriptor := db_spec.new_descriptor
				if immediate_execution then
					handle.status.set (db_spec.pre_immediate (temp_descriptor, 0))
					handle.status.set (db_spec.exec_immediate (temp_descriptor, tmp_string))
				else
					handle.status.set (db_spec.init_order (temp_descriptor, tmp_string))
					if is_ok then
						handle.status.set (db_spec.start_order (temp_descriptor))
					end
				--	if is_ok then
						handle.status.set (db_spec.terminate_order (temp_descriptor))
				--	end
				end
			end

		end

	force (obj: ANY) is
			-- Store `object' into supposingly fixed
			-- and resizable active repository.
		require
			object_exists: obj /= Void
			owns_repository: owns_repository
			repository_exists: repository.exists
		do
			put (obj)
		end

	set_default_numeric_field_value ( value: DOUBLE) is
			-- Set the value to represent a database null value.
		do
			db_default_null_value.set_value (value)
		end

feature {NONE} -- Status report

	previous_type: INTEGER
		-- Type of last object used to define `map_table'

	map_table: ARRAY [INTEGER]
		-- Correspondence table between table column rank and
		-- attribute rank of object to be stored.

	next_index (k: INTEGER): INTEGER is
			-- Value at k-th index in map table
		do
			Result := map_table.item (k)
		ensure then
			resulting_value: Result = map_table.item (k)
		end

	sql_string: STRING is
			-- Constant string
		once
			!! Result.make (256)
		end

feature {NONE} -- Status setting

	update_map_table (object: ANY) is
			-- Update map table according to field names of `object'.
		require
			not_void_object: object /= Void
			not_void_repository: repository /= Void
		local
			f, g, ind, idx: INTEGER
			searched_name: STRING
		do
			if
				previous_type = 0 or else 
				previous_type /= dynamic_type (object)
			then
				previous_type := dynamic_type (object)
				f := repository.dimension
				g := field_count  (object)
				map_table.clear_all
				if db_spec.dim_rep_diff (f, g) then
					make_default_table (g)
				else
					if map_table.count < f then
						map_table.resize (1, f)
					end
					from
						ind := 1
					until
						ind > f
					loop
						searched_name := repository.column_name (ind)
						searched_name.to_lower
						from
							idx := 1
						until
							idx > g or else 
							field_name (idx, object).is_equal (searched_name)
						loop
							idx := idx + 1
						end
						if idx > g then
							db_spec.update_map_table_error (handle, map_table, ind)
							ind := f + 1
						else
							map_table.put (idx, ind)
							ind := ind + 1
						end
					end
				end
			end
		end

	make_default_table (i: INTEGER) is
			-- Create and initialize map table of size `is' with default values.
		local
			j: INTEGER
		do
			if map_table = Void then
				!! map_table.make (1, i)
			elseif map_table.count < i then
				map_table.resize (1, i)
			end
			from
				j := 1
			until
				j > i
			loop
				map_table.put (j, j)
				j := j + 1
			end
		end

	start (object: ANY) is
			-- Set `max_index' to last non zero column rank.
			-- (Input parameter unused)
		do
			from
				max_index := map_table.count
			until
				map_table.item (max_index) /= 0
			loop
				max_index := max_index - 1
			end
		end

end -- class DATABASE_STORE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
