indexing
	description: "Routine identifier sets indexed by routine id."
	date: "$Date$"
	revision: "$Revision$"

class
	ROUT_ID_SET
	
inherit
	SHARED_COUNTER
		redefine
			is_equal, copy
		end
	
	COMPILER_EXPORTER
		redefine
			is_equal, copy
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Allocate current routine ID set.
		do
			first := Dead_value
		end

feature -- Access

	first: INTEGER
			-- First routine id.

	item (i: INTEGER): like first is
			-- Entry at index `i'.
		require
			valid_index: valid_index (i)
		do
			if i = 1 then
				Result := first
			else
				Result := area.item (i - 2)
			end
		end

feature -- Status report
		
	Lower: INTEGER is 1
			-- Lower bound of set.

	is_empty: BOOLEAN is
			-- Is set empty?
		do
			Result := first = Dead_value
		ensure
			is_empty_definition: Result implies count = 0
		end
		
	count: INTEGER is
			-- Number of routine IDs.
		local
			l_area: like area
		do
			l_area := area
			if l_area /= Void then
				Result := l_area.count + 1
			else
				if first /= Dead_value then
					Result := 1
				end
			end
		ensure
			count_nonnegative: count >= 0
		end
		
	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within bounds of current set?
		do
			Result := (1 <= i) and (i <= count)
		end
	
	has (a_rout_id: like first): BOOLEAN is
			-- Is routine id `a_rout_id' present in the set ?
		require
			a_rout_id_positive: a_rout_id >= 0
		local
			i, nb: INTEGER
			l_area: like area
		do
			Result := first = a_rout_id
			if not Result then
				l_area := area
				if l_area /= Void then
					from
						nb := l_area.count - 1
					until
						i > nb or Result
					loop
						Result := a_rout_id = l_area.item (i)
						i := i + 1
					end
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := first = other.first and equal (area, other.area)
		end
	
	same_as (other: like Current): BOOLEAN is
			-- Has `other' the same content than Current ?
		require
			other_not_void: other /= Void
		local
			i, nb: INTEGER
			l_area: like area
		do
			nb := count
			if nb = other.count and nb > 0 then
				Result := other.has (first)
				l_area := area
				if l_area /= Void then
					check
						nb_valid: nb > 1
					end
					from
						nb := nb - 2
						Result := True
					until
						i > nb or else not Result
					loop
						Result := other.has (l_area.item (i))
						i := i + 1
					end
				end
			end
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying all items of `other'.
			-- (This is also used by `clone'.)
		do
			if other /= Current then
				first := other.first
				if other.area /= Void then
					area := other.area.twin
				else
					area := Void
				end
			end
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [like first] is
			-- Representation as a linear structure
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := count
				create Result.make (nb)
			until
				i > nb
			loop
				Result.extend (item (i))
				i := i + 1
			end
		ensure
			linear_representation_not_void: Result /= Void
		end

feature {COMPILER_EXPORTER}

	put, force (a_rout_id: like first) is
			-- Insert routine id `a_rout_id' in set if not already
			-- present.
		require
			a_rout_id_positive: a_rout_id >= 0
		do
			extend (a_rout_id)
		ensure
			inserted: has (a_rout_id)
		end
	
	extend (a_rout_id: like first) is
			-- Insert routine id `a_rout_id' in set if not already
			-- present.
		require
			a_rout_id_positive: a_rout_id >= 0
		local
			l_rout_id: INTEGER
			l_pos: INTEGER
			l_area: like area
		do
			if not has (a_rout_id) then
					-- Routine id `a_rout_id' is not present in set.
				if first = Dead_value then
					first := a_rout_id
				else
					l_area := area
					if l_area /= Void then
						l_pos := l_area.count
					end
					l_area := new_area (l_area, l_pos + 1)
					area := l_area
					l_area.put (a_rout_id, l_pos)
				end

					-- Processing for attribute table:
					-- Since the byte code inspect the first value of this	
					-- routine id set, if there are thw ids one for a routine
					-- table and another one for an attribute table, the one
					-- for the attribute table must be in first position
				if
					Routine_id_counter.is_attribute (a_rout_id) and then
					not Routine_id_counter.is_attribute (first)
				then
					if l_area /= Void then
						l_rout_id := first
						first := a_rout_id
						l_area.put (l_rout_id, l_pos)
					end
				end
			end
		ensure
			inserted: has (a_rout_id)
		end

	has_attribute_origin: BOOLEAN is
			-- Is in routine id set an attribute offset table id?
		require
			not_empty: not is_empty
		do
			Result := Routine_id_counter.is_attribute (first)
		end
			
	update (l: LINKED_LIST [INHERIT_INFO]) is
			-- Update through inherited features in `l'.
		require
			l_not_void: l /= Void
			l_not_empty: not l.is_empty
		do
			from
				l.start
			until
				l.after
			loop
				merge (l.item.a_feature.rout_id_set)
				l.forth
			end
		end

	merge (other: like Current) is
			-- Put routine ids of `other' not present in Current.
		require
			good_argument: other /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := other.count
			until
				i > nb
			loop
				extend (other.item (i))
				i := i + 1
			end
		end

	wipe_out is
			-- Clear the structure.
		do
			first := Dead_value
			area := Void
		ensure
			is_empty: is_empty
		end

feature -- Output

	trace is
			-- Debug purpose. Not efficient at all.
		local
			i: INTEGER
		do
			io.error.put_character ('[')
			from
				i := 1
			until
				i > count
			loop
				io.error.put_integer (item (i))
				io.error.put_character (' ')
				i := i + 1
			end
			io.error.put_character (']')
		end

feature {ROUT_ID_SET} -- Implementation: access

	area: SPECIAL [INTEGER]
			-- Hold additional routine IDs.

feature {NONE} -- Implementation

	dead_value: INTEGER is -1
			-- Special value to show that `first' is not yet set.

	new_area (a_old_area: like area; a_count: INTEGER): like area is
			-- Duplicate `old_area' to accomodate `n' element.
		require
			a_count_positive: a_count > 0
		local
			l_ar: ARRAY [INTEGER]
		do
			if a_old_area /= Void then
				Result := a_old_area.aliased_resized_area (a_count)
			else
				create l_ar.make (1, a_count)
				Result := l_ar.area
			end
		ensure
			new_area_not_void: Result /= Void
			new_area_correct_count: Result.count = a_count
			new_area_correct_values: a_old_area = Void implies Result.all_default (a_count - 1)
		end
		
end -- class ROUT_ID_SET
