indexing

	description:
		"Sets implemented by linked lists";

	copyright: "See notice at end of class";
	names: linked_set, set, linked_list;
	representation: linked;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_SET [G] inherit

	SUBSET [G]
		undefine
			prune_all
		select
			extend, put
		end;

	 LINKED_LIST [G]
		rename
			extend as ll_extend,
			put as ll_put
		export
			{NONE} all
			{LINKED_SET} forth, item, off, start
		undefine
			changeable_comparison_criterion
		end;

creation

	make

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is current set a subset of `other'?
		do
			if not other.empty then
				from
					start
				until
					off or else not other.has (item)
				loop
					forth
				end;
				if off then Result := true end
			elseif empty then
				Result := true
			end
		end;

feature -- Element change

	put, extend (v: G) is
			-- Ensure that set includes `v'.
		do
			if empty or else not has (v) then
				put_front (v)
			end
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		do
			from
				other.start
			until
				other.off
			loop
				extend (other.item);
				other.forth
			end
		end;

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
			-- No effect if `other' is `empty'.
		do
			if not other.empty then
				from
					start;
					other.start
				until
					off
				loop
					if other.has (item) then
						forth
					else
						remove
					end
				end
			else
				wipe_out
			end
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		do
			if not (other.empty or empty) then
				from
					start;
					other.start
				until
					off
				loop
					if other.has (item) then
						remove
					else
						forth
					end
				end
			end
		end;

end -- class LINKED_SET


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
