indexing

	description:
		"Sets implemented by linked lists";

	status: "See notice at end of class";
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
			extend, put, prune
		end;

	LINKED_LIST [G]
		rename
			extend as ll_extend,
			put as ll_put,
			prune as ll_prune
		export
			{NONE} ll_extend, ll_put, ll_prune
		undefine
			changeable_comparison_criterion
		end;

creation

	make

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is current set a subset of `other'?
		do
			if not other.empty and then count <= other.count then
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
feature -- Removal

	prune (v : like item) is
		-- Remove `v' if present.
		do
			start
			ll_prune (v)
		end

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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

