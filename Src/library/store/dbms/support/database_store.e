note
	description: "Implementation of DB_STORE"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STORE [reference G -> DATABASE create default_create end]

inherit

	DB_STATUS_USE
		undefine
			is_equal, out, copy
		end

	DB_EXEC_USE
		undefine
			is_equal, out, copy
		end

	SQL_SCAN [G]
		rename
			make as scan_make,
			put as string_put
		redefine
			start, next_index
		end

create -- Creation procedure

	make

create {DATABASE_STORE}
	string_make, scan_make

feature -- Initialization

	make (size: INTEGER)
		do
			create ht.make (1)
			create ht_order.make (1)
			ht_order.compare_objects
			create map_table.make_filled (0, 1, 10)
			scan_make (size)
		end

feature -- Status setting

	set_repository (one_repository: DATABASE_REPOSITORY[G])
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

	repository: detachable DATABASE_REPOSITORY[G]
			-- Associated repository

	owns_repository: BOOLEAN
			-- Is the current store operation associated
			-- with a repository?
		do
			Result := repository /= Void
		ensure
			existence_condition: Result = (repository /= Void)
		end

feature -- Basic operations

	put (object: ANY)
			-- Store `object' into active repository.
		require
			object_exists: object /= Void
			owns_repository: owns_repository
			repository_exists: attached repository as lr_repository and then lr_repository.exists
		local
			tmp_string: like parse_32
			temp_descriptor: INTEGER
			quoter: STRING_32
			sep: STRING_32
		do
			if attached repository as l_repository and attached map_table as l_map_table then
				update_map_table (object)
				create quoter.make(1)
				create sep.make(1)
				quoter := db_spec.identifier_quoter
				sep := db_spec.qualifier_separator
				sql_string.wipe_out
				sql_string.append ({STRING_32} "INSERT INTO ")
				if (l_repository.rep_qualifier /= Void and then l_repository.rep_qualifier.count > 0) then
					sql_string.append(quoter)
					sql_string.append_string_general(l_repository.rep_qualifier)
					sql_string.append(quoter)
				end
				if (l_repository.rep_owner /= Void and then l_repository.rep_owner.count > 0) then
					sql_string.append(sep)
					sql_string.append(quoter)
					sql_string.append_string_general(l_repository.rep_owner)
					sql_string.append(quoter)
				end
				if ((l_repository.rep_owner /= Void and then l_repository.rep_owner.count > 0) or (l_repository.rep_qualifier /= Void and then l_repository.rep_qualifier.count > 0)) then
					sql_string.append_character ({CHARACTER_32} '.')
				end
				sql_string.append(quoter)
				sql_string.append_string_general (l_repository.repository_name)
				sql_string.append(quoter)
				sql_string.append_string_general(db_spec.put_column_name(l_repository, l_map_table, object))
				sql_string.append ({STRING_32} " VALUES ( :XZ7Hj0sb5UU )")
				set_map_name (object, {STRING_32} "XZ7Hj0sb5UU")
				tmp_string := parse_32 (sql_string)
				unset_map_name ({STRING_32} "XZ7Hj0sb5UU")
				if tmp_string /= Void then
					temp_descriptor := db_spec.new_descriptor
					if is_ok then
						if immediate_execution then
							db_spec.pre_immediate (temp_descriptor, 0)
							db_spec.exec_immediate (temp_descriptor, tmp_string)
						else
							db_spec.init_order (temp_descriptor, tmp_string)
							if is_ok then
								db_spec.start_order (temp_descriptor)
							end
							if is_ok then
								db_spec.terminate_order (temp_descriptor)
							end
						end
					end
				end
			end
		end

	force (obj: ANY)
			-- Store `object' into supposingly fixed
			-- and resizable active repository.
		require
			object_exists: obj /= Void
			owns_repository: owns_repository
			repository_exists: attached repository as lr_repository and then lr_repository.exists
		do
			put (obj)
		end

feature {NONE} -- Status report

	previous_type: INTEGER
		-- Type of last object used to define `map_table'

	map_table: detachable ARRAY [INTEGER]
		-- Correspondence table between table column rank and
		-- attribute rank of object to be stored.

	next_index (k: INTEGER): INTEGER
			-- Value at k-th index in map table
		do
			if attached map_table as l_map_table then
				Result := l_map_table.item (k)
			else
				Result := k
			end
		ensure then
			resulting_value: attached map_table as le_map_table implies Result = le_map_table.item (k)
		end

	sql_string: STRING_32
			-- Constant string
		once
			create Result.make (256)
		end

feature {NONE} -- Status setting

	update_map_table (object: ANY)
			-- Update map table according to field names of `object'.
		require
			not_void_object: object /= Void
			not_void_repository: repository /= Void
			not_void_map_table: map_table /= Void
		local
			f, g, ind, idx: INTEGER
--			colind: INTEGER
		do
			if attached repository as l_repository and attached map_table as l_map_table then
				f := l_repository.dimension
				g := field_count  (object)
--				if l_table /= Void and then l_table.table_description.identity_column > 0 then
--					colind := l_table.table_description.identity_column			
--					f := f - 1
--					g := g - 1
--				end

				if
					previous_type = 0 or else
					previous_type /= dynamic_type (object)
				then
					previous_type := dynamic_type (object)
					l_map_table.clear_all
					if db_spec.dim_rep_diff (f, g) then
						make_default_table (g)
					else
						if l_map_table.count < f then
							l_map_table.conservative_resize_with_default (0, 1, f)
						end
						from
							ind := 1
						until
							ind > f
						loop
--							if not (ind = colind) then	
								if attached l_repository.column_name (ind) as searched_name then
									searched_name.to_lower
									from
										idx := 1
									until
										idx > g or else
										field_name (idx, object).is_equal (searched_name)
									loop
										idx := idx + 1
									end
								else
									idx := g + 1
								end
								if idx > g then
									db_spec.update_map_table_error (handle, l_map_table, ind)
								else
									l_map_table.put (idx, ind)
								end
								ind := ind + 1
--							else
--								ind := ind + 1
--							end
						end
					end
				end
			end
		end

	make_default_table (i: INTEGER)
			-- Create and initialize map table of size `is' with default values.
		local
			j: INTEGER
			l_map_table: like map_table
		do
			l_map_table := map_table
			if l_map_table = Void then
				create l_map_table.make_filled (0, 1, i)
				map_table := l_map_table
			elseif l_map_table.count < i then
				l_map_table.conservative_resize_with_default (0, 1, i)
			end
			from
				j := 1
			until
				j > i
			loop
				l_map_table.put (j, j)
				j := j + 1
			end
		end

	start (object: ANY)
			-- Set `max_index' to last non zero column rank.
			-- (Input parameter unused)
		do
			if attached map_table as l_map_table then
				from
					max_index := l_map_table.count
				until
					l_map_table.item (max_index) /= 0
				loop
					max_index := max_index - 1
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_STORE


