-- Cache of horizontal tables for final mode generation

class
	EIFFEL_HISTORY

inherit
	SHARED_SERVER

	COMPILER_EXPORTER

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			!! used.make (Default_size);
		end;

feature 

	poly_table (rout_id: ROUTINE_ID): POLY_TABLE [ENTRY] is
			-- Routine table of id `rout_id'
		do
			if Tmp_poly_server.has (rout_id) then
					-- Not in cache and the routine id is not associated
					-- to a routine table of deferred features only.
				Result := Tmp_poly_server.item (rout_id);
			end;
		end;

	start_degree_minus_5 (count: INTEGER) is
			-- Create the data structures which are going to be used at degree -5.
		do
			!! is_polymorphic_table.make (0, count)
			!! min_id_table.make (0, count)
		end

	finish_degree_minus_5 is
			-- Clean all the data structures used during degree -5.
		local
			i, nb: INTEGER
		do
			from
				i := is_polymorphic_table.lower
				nb := is_polymorphic_table.upper
			until
				i > nb
			loop
					-- Free the table if it exists
				table_free (is_polymorphic_table.item (i))	
				i := i + 1
			end
			min_id_table := Void
			is_polymorphic_table := Void
		end

	is_polymorphic (rout_id: ROUTINE_ID; class_type_id: INTEGER;
					used_requested: BOOLEAN): INTEGER is
			-- If the entry <`rout_id',`class_type_id'> is polymorphic, we return
			-- `min_used' if `used_requested', `min_type_id' otherwise.
			-- If the entry is not polymorphic we return `-1'.
			-- If the entry does not have a polymorphic table, we return `-2'
		require
			valid_rout_id: rout_id /= Void
			is_polymorphic_table_exists: is_polymorphic_table /= Void
		local
			bool_array, null: POINTER
			id: INTEGER
			status: BOOLEAN
			entry: POLY_TABLE [ENTRY]
			temp_result: INTEGER
		do
			id := rout_id.id

				-- Get the array corresponding to the searched value
			bool_array := is_polymorphic_table.item (id)

			if bool_array /= null then
					-- We already have computed something for this polymorphic
					-- table, we just need to search for the requested `class_type_id'
					-- to know if we can retrieve the value or if we had to compute it.
				Result := get_value (bool_array, class_type_id)
				if Result = is_feature_not_yet_computed then
						-- The entry has not yet been computed
					entry := poly_table (rout_id)
					status := entry.is_polymorphic (class_type_id)
					put_value (bool_array, class_type_id, status)
					if status then
						Result := min_id_table.item (id)
					else
						Result := - 1
					end
				elseif Result = is_feature_polymorphic then
					Result := min_id_table.item (id)
				else
					Result := -1
				end
			else
					-- First time, the information for <`rout_id',`class_type_id'> is requested
				entry := poly_table (rout_id)

				if entry /= Void then
						-- Create the C array with the bounds `0' to `entry.max_type_id'.
					bool_array := create_table (entry.max_type_id)
	
						-- Store the polymorphic status of the searched entry. 
					status := entry.is_polymorphic (class_type_id)

						-- When we are handling with a ROUT_TABLE, we need to store
						-- the `min_used' id, otherwise its enough to store the
						-- `min_type_id'.
					if used_requested then
						min_id_table.put (entry.min_used -1, id)
					else
						min_id_table.put (entry.min_type_id -1, id)
					end

						-- Store the value in the C array.
					put_value (bool_array, class_type_id, status)
	
						-- Insert the new computed table in the array of computed tables.
					is_polymorphic_table.put (bool_array, id)
	
						-- Return the result
					if status then
						Result := min_id_table.item (id)
					else
						Result := -1
					end
				else
						-- In case there is no polymorphic table associated to `rout_id'
						-- we don't do anything and next time we will go to the same place.
					Result := -2
				end
			end
		end

	is_used (rout_id: ROUTINE_ID): BOOLEAN is
			-- Is the table of routine id `rout_id' used ?
		require
			rout_id_not_void: rout_id /= Void
		do
			Result := used.has (rout_id)
		end;

	mark_used (rout_id: ROUTINE_ID) is
			-- Mark routine table of routine id `rout_id' used.
		require
			rout_id_not_void: rout_id /= Void
		do
			used.force (rout_id)
		end;

	wipe_out is
			-- Wipe out the structure
		do
		end;

feature -- Implementation

	used: SEARCH_TABLE [ROUTINE_ID];
			-- Used routine table ids

	is_polymorphic_table: ARRAY [POINTER]
			-- Array of C arrays which knows if a certain
			-- ROUTINE_ID in a certain TYPE_ID is polymorphic or not.
			--| They are created on the fly during the degree -5.

	min_id_table: ARRAY [INTEGER]
			-- Array of INTEGER which contains for each
			-- Poly_table its `min_type_id' and `min_used_id'.

	default_size: INTEGER is 200;
			-- Cache size

feature {NONE} -- Externals

	create_table (size: INTEGER): POINTER is
			-- Create a C array of `size'.
		external
			"C | %"special_tables.h%""
		alias
			"table_malloc"
		end

	table_free (p: POINTER) is
			-- Free the previously created table with `create_table'.
		external
			"C | %"special_tables.h%""
		alias
			"table_free"
		end

	get_value (p: POINTER; class_type_id: INTEGER): INTEGER is
			-- Get the polymorphic status for current table `p' corresponding
			-- to a certain ROUTINE_ID and a certain `class_type_id'.
		external
			"C | %"special_tables.h%""
		end

	put_value (p: POINTER; class_type_id: INTEGER; v: BOOLEAN) is
			-- Set the polymorphic status for current table `p' corresponding
			-- to a certain ROUTINE_ID and a certain `class_type_id'.
		external
			"C | %"special_tables.h%""
		end

	is_feature_polymorphic: INTEGER is 3
	is_feature_not_polymorphic: INTEGER is 2
	is_feature_not_yet_computed: INTEGER is -1

invariant
	used_not_void: used /= Void

end
