-- List of breakpoint setting instructions.
-- Only one instruction (setting or removal) per breakpoint.
-- (Breakpoints are equal if they represente the same physical
-- point in the byte code, that's to say tahat they share the 
-- same real_body_id and offset).
--| Object comparison is not yet supported in the bench internal
--| version of the library. Therefore some instructions have
--| been commented out and the feature clause "Object comparison features"
--| holds redefined routines which were implemented with reference instead
--| of object comparison.

class

	BREAK_LIST

inherit

	LINKED_SET [BREAKPOINT]
		rename
--			extend as ls_extend,
			append as ls_append,
			make as ls_make
		export
			{NONE} ls_make, replace;
			{NONE} ls_append, fill, merge_left, merge_right;
			{NONE} put; --put_front, force, ls_extend
			{NONE} put_i_th, put_left, put_right
		redefine
			index_of
		end

creation

	make

feature -- Object comparison features

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- (Object comparison)
			-- 0 if none.
		local
			occurrences, pos: INTEGER
		do
			start;
			pos := 1;
			from
			until
				off or else (occurrences = i)
			loop
				if v.is_equal (item) then
					occurrences := occurrences + 1;
				end;
				forth;
				pos := pos + 1
			end;
			if occurrences = i then
				Result := pos - 1
			end
		end;

feature -- Initialization

	make is
			-- Create an empty list with object comparison mode.
		do
			ls_make;
--			compare_objects
		end;
			
feature -- Element change

	extend (bp: BREAKPOINT) is
			-- Add the new breakpoint instruction to the list.
			-- If an instruction for the same breakpoint 
			-- is already held in the list, this instruction
			-- is removed or left in the list whether it is
			-- in contradiction with `bp' or not.
		require
			bp_exists: bp /= Void
		do
			if not has (bp) then
--				put_front (bp)
				add (bp)
			elseif i_th (index_of (bp, 1)).is_continue /= bp.is_continue then
--				start;
--				prune (bp)
				go_i_th (index_of (bp, 1));
				remove
			end
		end;

	append (other: like Current) is
			-- Add breakpoint instructions held in `other' into `Current'.
		require
			other_exists: other /= Void
		do
			from
				other.start
			until
				other.after
			loop
				extend (other.item);
				other.forth
			end
		end;

invariant

--	object_comparison: object_comparison

end -- class BREAK_LIST
	
