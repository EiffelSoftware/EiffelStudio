indexing
	description: "Class which redefine the notion of array%
				%in order to be able to use it in a Matisse%
				%database.%
				%If you have an attribute of type ARRAY and you want%
				%to store/retreive from the database, you must%
				%switch to MT_ARRAY."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_ARRAY [G -> MT_STORABLE]

inherit
	ARRAY [G]
		rename
			put as array_put, 
			enter as array_enter,
			wipe_out as array_wipe_out
		export 
			{NONE} array_put, array_enter, array_wipe_out
		redefine
			force, subcopy, clear_all, copy, prunable
		end
	
	ARRAY [G]
		rename
			put as array_put
		redefine
			enter, wipe_out, prunable, force, subcopy, clear_all, copy
		select
			enter, wipe_out
		end
		
	MT_RS_CONTAINABLE
		undefine
			is_equal, copy, consistent, setup
		end

	MT_LINEAR_COLLECTION [G]
		undefine
			is_equal, copy, consistent, setup
		end

creation
	make

feature -- Access

	put, enter (v: like item; i: INTEGER) is
		require else
			valid_key: valid_index (i)
		do
			if is_persistent then
				if item (i) /= Void then
					mt_remove (item (i))
				end
				if v /= Void then
					check_persistence (v)
					if i = lower then
						mt_add_first (v)
					else
						mt_add_after (v, item (i - 1))
					end
				end
			end
			array_put (v, i)
		end
	
	force (v: like item; i: INTEGER) is
			-- Assign item `v' to `i'-th entry.
			-- Always applicable: resize the array if `i' falls out of
			-- currently defined bounds; preserve existing items.
		do
			if i < lower then
				auto_resize (i, upper)
			elseif i > upper then
				auto_resize (lower, i)
			end
			put (v, i)
		end
	
	subcopy (other: like Current; start_pos, end_pos, index_pos: INTEGER) is
			-- Copy items of `other' within bounds `start_pos' and `end_pos'
			-- to current array starting at index `index_pos'.
		local
			other_area: like area;
			other_lower, i: INTEGER;
			start0, end0, index0: INTEGER
		do
			if is_persistent then
				from 
					i := other.lower
				until 
					i > other.upper
				loop
					check_persistence (other.item (i))
					i := i + 1
				end
			end
			other_area := other.area;
			other_lower := other.lower;
			start0 := start_pos - other_lower;
			end0 := end_pos - other_lower;
			index0 := index_pos - lower;
			spsubcopy ($other_area, $area, start0, end0, index0)
			if is_persistent then
				mt_set_all
			end
		end

	clear_all is
			-- Reset all items to default values.
		do
			{ARRAY} Precursor
			mt_remove_all
		end;

	wipe_out is
			-- Make array empty.
		do
			discard_items
			mt_remove_all
		end
	
	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end;

feature -- Inapplicable

	copy (other: like Current) is
			-- Reinitialize by copying all the items of `other'.
			-- (This is also used by `clone').
		do
		end

feature {NONE} -- Implementation

	mt_put_at_loading (new: G; i: INTEGER) is
		do
			array_put (new, lower + i - 1)
		end

	mt_resize_at_loading (new_size: INTEGER) is
		do
			resize (lower, lower + new_size - 1)
		end
	
	wipe_out_at_reverting is
		do
			discard_items
		end
	
end -- class MT_ARRAY


