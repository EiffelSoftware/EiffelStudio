indexing

	description:
		"General container data structures, %
		%characterized by the membership properties of their items.";

	copyright: "See notice at end of class";
	names: collection, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COLLECTION [G] inherit

	CONTAINER [G]

feature -- Status report

	extendible: BOOLEAN is
			-- May new items be added?
		deferred
		end;

	prunable: BOOLEAN is
			-- May items be removed?
		deferred
		end;

feature -- Element change

	put, extend (v: G) is
			-- Ensure that structure includes `v'.
		require
			extendible: extendible
		deferred
		ensure
			item_inserted: has (v)
		end;

	fill (other: CONTAINER [G]) is
			-- Fill with as many elements of `other' as possible.
			-- The representations of `other' and `Current' need not
			-- be the same.
		require
				  other_not_void: other /= Void;
				  extendible: extendible
		local
			lin_rep: SEQUENTIAL [G]
		do
			lin_rep := other.sequential_representation;
			from
				lin_rep.start
			until
				not extendible or else lin_rep.off
			loop
				extend (lin_rep.item);
				lin_rep.forth
			end
		end;

feature -- Removal

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
			-- (Reference or object equality, based on `object_comparison'.)
		require
			prunable: prunable
		deferred
		end;

	prune_all (v: G) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality, based on `object_comparison'.)
			--|Default implementation, usually inefficient.
		require
			prunable: prunable
		do
			from
			until not has (v) loop
				prune (v)
			end
		ensure
			no_more_occurences: not has (v)	
		end;

	wipe_out is
			-- Remove all elements.
		require
			prunable: prunable
		deferred
		ensure
			wiped_out: empty
		end;

end -- class COLLECTION


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
