indexing
	description: "List of all breakpoints currently set. %
				 %Breakpoints can be enabled, disabled, or not set. %
				 %(Breakpoints are equal if they represente the same physical %
				 %point in code, that's to say that they share the %
				 %same body_index and line number)."
	author: "Arnaud PICHERY (aranud@mail.dotcom.fr)"
	date: "$Date$"
	revision: "$Revision$"

class
	BREAK_LIST 

inherit
	HASH_TABLE [BREAKPOINT, BREAKPOINT]
		rename
			make as ht_make
		end

creation
	make

feature -- Initialization

	make is
			-- Create an empty list of break points.
		do
			ht_make (50)
		end
			
feature -- Element change

	add_breakpoint (bp: BREAKPOINT) is
			-- Add the new breakpoint `bp' to the list.
			-- If a breakpoint is already held in the
			-- list, the breakpoint is set and activated.
		require else
			bp_exists: bp /= Void
		do
			if not has (bp) then
				put (bp, bp)
			else
				found_item.enable
			end
		end

	append (other: like Current) is
			-- Add breakpoints held in `other' into `Current'.
		require
			other_exists: other /= Void
		do
			from
				other.start
			until
				other.off
			loop
				add_breakpoint (other.item_for_iteration)
				other.forth
			end
		end

end -- class BREAK_LIST
	
