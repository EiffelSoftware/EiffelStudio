-- List of breakpoint setting instructions.
-- Only one instruction (setting or removal) per breakpoint.
-- (Breakpoints are equal if they represente the same physical
-- point in the byte code, that's to say tahat they share the 
-- same real_body_id and offset).

class

	BREAK_LIST

inherit

	LINKED_SET [BREAKPOINT]
		rename
			extend as ls_extend,
			append as ls_append,
			make as ls_make
		export
			{NONE} ls_make, replace;
			{NONE} ls_append, fill, merge_left, merge_right;
			{NONE} put, put_front, force, ls_extend;
			{NONE} put_i_th, put_left, put_right
		select
			ls_extend, ls_append, ls_make
		end

	LINKED_SET [BREAKPOINT]
		redefine
			extend, make, append
		end

creation

	make

feature -- Initialization

	make is
			-- Create an empty list with object comparison mode.
		do
			ls_make;
			compare_objects
		end;
			
feature -- Element change

	extend (bp: BREAKPOINT) is
			-- Add the new breakpoint instruction to the list.
			-- If an instruction for the same breakpoint 
			-- is already held in the list, this instruction
			-- is removed or left in the list whether it is
			-- in contradiction with `bp' or not.
		require else
			bp_exists: bp /= Void
		do
			if not has (bp) then
				put_front (bp)
			elseif i_th (index_of (bp, 1)).is_continue /= bp.is_continue then
				start;
				prune (bp)
			end
		end;

	append (other: like Current) is
			-- Add breakpoint instructions held in `other' into `Current'.
		require else
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

	object_comparison: object_comparison

end -- class BREAK_LIST
	
