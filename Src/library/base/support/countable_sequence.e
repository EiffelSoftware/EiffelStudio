indexing
	description:
		"Infinite sequences, indexed by integers";
	status: "See notice at end of class";
	names: countable_sequence, infinite_sequence;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COUNTABLE_SEQUENCE [G]

inherit

	COUNTABLE [G]
		rename
			item as i_th
		end

	ACTIVE [G]
		export
			{NONE}
					fill, prune_all, put,
					prune,
					wipe_out, replace, remove
		end

	LINEAR [G]
		redefine
			linear_representation
		end

feature -- Access

	i_th (i: INTEGER): G is
			-- Item of rank `i'
		deferred
		end;

	index: INTEGER
			-- Index of current position

	item: G is
			-- Item at current position
		do
			Result := i_th (index)
		end;

feature -- Status report

	after: BOOLEAN is false;
			-- Is current position past last item? (Answer: no.)

	extendible: BOOLEAN is false;
			-- May items be added? (Answer: no.)

	prunable: BOOLEAN is false;
			-- May items be removed? (Answer: no.)

	readable: BOOLEAN is true;
			-- Is there a current item that may be read?
			-- (Answer: yes.)

	writable: BOOLEAN is false
			-- Is there a current item that may be written?
			-- (Answer: no.)

feature -- Cursor movement

	forth is
			-- Move to next position.
		do
			index := index + 1
		end;

	start is
			-- Move to first position.
		do
			index := 1
		end;

feature {NONE} -- Inapplicable

	extend (v: G) is
			-- Add `v' at end.
		do
		end;

	finish is
			-- Move to last position.
		do
		ensure then
			failure: false
		end;

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		do
		end;

	prune (v: G) is
			-- Remove first occurrence of `v', if any.
		do
		end;

	put (v: G) is
			-- Add `v' to the right of current position.
		do
		end;

	remove is
			-- Remove item to the right of current position.
		do
		end;

	replace (v: G) is
			-- Replace by `v' item at current position.
		do
		end;

	wipe_out is
			-- Remove all items.
		do
		end;

end -- class COUNTABLE_SEQUENCE

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
