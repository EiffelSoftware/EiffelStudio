-- List of breakpoint setting instructions.
-- Only one instruction (setting or removal) per breakpoint.
-- (Breakpoints are equal if they represente the same physical
-- point in the byte code, that's to say that they share the 
-- same real_body_id and offset).

class
	BREAK_LIST 

inherit
	HASH_TABLE [BREAKPOINT, BREAKPOINT]
		rename
			make as ht_make,
			extend as ht_extend
		end

creation
	make

feature -- Initialization

	make is
			-- Create an empty list of break points.
		do
			ht_make (50)
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
				put (bp, bp)
			elseif found_item.is_continue /= bp.is_continue then
				remove (bp)
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
				other.off
			loop
				extend (other.item_for_iteration);
				other.forth
			end
		end;

end -- class BREAK_LIST
	
