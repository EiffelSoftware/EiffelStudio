indexing
	description: "Cache for storing polymorphic status of call to a certain feature%
		%with a routine id in the context of a class type id for final mode generation"
	date: "$Date$"
	revision: "$Revision$"

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
			create used.make (Default_size)
		end

feature -- Access

	poly_table (rout_id: INTEGER): POLY_TABLE [ENTRY] is
			-- Routine table of id `rout_id'
		do
			if Tmp_poly_server.has (rout_id) then
					-- Not in cache and the routine id is not associated
					-- to a routine table of deferred features only.
				Result := Tmp_poly_server.item (rout_id)
			end
		end

	used: SEARCH_TABLE [INTEGER]
			-- Used routine table ids

feature -- Process

	start_degree_minus_3 (count: INTEGER) is
			-- Create the data structures which are going to be used at degree -3.
		do
			create is_polymorphic_table.make (0, count)
			create min_id_table.make (0, count)
		end

	finish_degree_minus_3 is
			-- Clean all the data structures used during degree -3.
		do
			min_id_table := Void
			is_polymorphic_table := Void
		end

feature -- Status

	is_polymorphic (rout_id: INTEGER; class_type_id: INTEGER
					used_requested: BOOLEAN): INTEGER is
			-- If the entry <`rout_id',`class_type_id'> is polymorphic, we return
			-- `min_used' if `used_requested', `min_type_id' otherwise.
			-- If the entry is not polymorphic we return `-1'.
			-- If the entry does not have a polymorphic table, we return `-2'
		require
			is_polymorphic_table_exists: is_polymorphic_table /= Void
			positive_rout_id: rout_id > 0
		local
			bool_array: PACKED_BOOLEANS
			status: BOOLEAN
			entry: POLY_TABLE [ENTRY]
			min_id: INTEGER
		do
				-- Get the array corresponding to the searched value
				-- if it is a valid `rout_id', if not `bool_array' is
				-- set to `Void' because we we have most probably a
				-- case of a deferred feature without implementation
				-- (This will be verified later).
			if rout_id <= is_polymorphic_table.upper then
				bool_array := is_polymorphic_table.item (rout_id)
			end

			if bool_array /= Void then
					-- Compute minimum class type id for current `rout_id'.
				min_id := min_id_table.item (rout_id)
				
					-- We already have computed something for this polymorphic
					-- table, we just need to search for the requested `class_type_id'
					-- to know if we can retrieve the value or if we had to compute it.
				if class_type_id >= min_id then
					Result := get_value (bool_array, class_type_id - min_id)
				else
					Result := is_feature_not_yet_computed
				end

				if Result = is_feature_not_yet_computed then
						-- The entry has not yet been computed
					entry := poly_table (rout_id)
					status := entry.is_polymorphic (class_type_id)
					if class_type_id >= min_id then
						put_value (bool_array, class_type_id - min_id, status)
					end
					if status then
						Result := min_id
					else
						Result := - 1
					end
				elseif Result = is_feature_polymorphic then
					Result := min_id
				else
					Result := -1
				end
			else
					-- First time, the information for <`rout_id',`class_type_id'> is requested
				entry := poly_table (rout_id)

				if entry /= Void then
						-- Store the polymorphic status of the searched entry. 
					status := entry.is_polymorphic (class_type_id)

						-- When we are handling with a ROUT_TABLE, we need to store
						-- the `min_used' id, otherwise its enough to store the
						-- `min_type_id'.
					if used_requested then
						min_id := entry.min_used - 1
					else
						min_id := entry.min_type_id - 1
					end
					min_id_table.put (min_id, rout_id)

						-- Create packed booleans array with bounds `2 * min_id'
						-- to `2 * entry.max_type_id'. `2' is because for each entry we store
						-- two informations: `is_computed' and then `is_polymorphic'.
					create bool_array.make (2 * (entry.max_type_id - min_id))

						-- Store the value in the C array.
					if class_type_id >= min_id then
						put_value (bool_array, class_type_id - min_id, status)
					end
	
						-- Insert the new computed table in the array of computed tables.
					is_polymorphic_table.put (bool_array, rout_id)
	
						-- Return the result
					if status then
						Result := min_id
					else
						Result := -1
					end
				else
						-- In case there is no polymorphic table associated to `rout_id'
						-- we don't do anything and next time we will go to the same place.
						-- Most probably a deferred feature without implementation
					Result := -2
				end
			end
		end

	is_used (rout_id: INTEGER): BOOLEAN is
			-- Is the table of routine id `rout_id' used ?
		require
			rout_id_not_void: rout_id /= 0
		do
			Result := used.has (rout_id)
		end

feature -- Element change

	mark_used (rout_id: INTEGER) is
			-- Mark routine table of routine id `rout_id' used.
		require
			rout_id_not_void: rout_id /= 0
		do
			used.force (rout_id)
		end

	wipe_out is
			-- Wipe out the structure
		do
			used.wipe_out
		end

feature -- Implementation

	is_polymorphic_table: ARRAY [PACKED_BOOLEANS]
			-- Array of arrays which knows if a certain
			-- routine id in a certain type id is polymorphic or not.
			--| They are created on the fly during the degree -5.

feature {NONE} -- Implementation

	min_id_table: ARRAY [INTEGER]
			-- Array of INTEGER which contains for each
			-- Poly_table its `min_type_id' and `min_used_id'.

	put_value (bool_array: PACKED_BOOLEANS; index: INTEGER; status: BOOLEAN) is
			-- Mark feature call to routine represented by `bool_array' with
			-- `status' polymorphic for `index'.
		require
			bool_array_not_void: bool_array /= Void
			valid_index: index >= 0
		local
			i: INTEGER
		do
			i := 2 * index
			bool_array.force (True, i)
			bool_array.force (status, i + 1)
		ensure
			status_implies: status implies
				get_value (bool_array, index) = is_feature_polymorphic
			not_status_implies: not status implies
				get_value (bool_array, index) = is_feature_not_polymorphic
		end

	get_value (bool_array: PACKED_BOOLEANS; index: INTEGER): INTEGER is
			-- Is feature call to routine represented by `bool_array' polymorphic
			-- for `index'?
		require
			bool_array_not_void: bool_array /= Void
			valid_index: index >= 0
		local
			i: INTEGER
		do
			i := 2 * index
				-- We already know that `index' is positive. If `index' has
				-- a greater value than the expected one, it means that we
				-- are either in an incremental finalization or that we are
				-- using a precompiled library. And that it means that we
				-- are currently on a deferred routine that is not part
				-- of the POLY_TABLE, thus we need to do some computation
				-- about the polymorphism status.
			if bool_array.valid_index (i + 1) then
				if bool_array.item (i) then
					if bool_array.item (i + 1) then
						Result := is_feature_polymorphic
					else
						Result := is_feature_not_polymorphic
					end
				else
					Result := is_feature_not_yet_computed
				end
			else
				Result := is_feature_not_yet_computed
			end
		ensure
			valid_result: Result = is_feature_polymorphic or
						Result = is_feature_not_polymorphic or
						Result = is_feature_not_yet_computed
		end

feature {NONE} -- Constants

	is_feature_polymorphic: INTEGER is 3
	is_feature_not_polymorphic: INTEGER is 2
	is_feature_not_yet_computed: INTEGER is -1

	default_size: INTEGER is 200
			-- Cache size

invariant
	used_not_void: used /= Void

end
