indexing
	description:
		"Stacks (last-in, first-out dispensers), without commitment %
		%to a particular representation";

	status: "See notice at end of class";
	names: stack, dispenser;
	access: fixed, lifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class STACK [G] inherit

	DISPENSER [G]
		export
			{NONE} prune, prune_all
		redefine
			extend, force, put, fill
		end;

feature -- Element change

	extend, force, put (v: like item) is
			-- Push `v' onto top.
		deferred
		ensure then
			item_pushed: item = v
		end;

	replace (v: like item) is
			-- Replace top item by `v'.
		do
			remove;
			extend (v)
		end;

	fill (other: LINEAR [G]) is
			-- Fill with as many items of `other' as possible.
			-- Fill items with greatest index from `other' first.
			-- Items inserted with lowest index (from `other') will
			-- always be on the top of stack.
			-- The representations of `other' and current structure
			-- need not be the same.
		local
			temp: ARRAYED_STACK [G]
		do
			!! temp.make (0);
			from
				other.start
			until
				other.off
			loop
				temp.extend (other.item);
				other.forth
			end;
			from
			until
				temp.empty or else not extendible
			loop
				extend (temp.item);
				temp.remove
			end
		end;

end -- class STACK


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
