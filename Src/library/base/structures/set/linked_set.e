--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sets implemented with linked lists

indexing

	names: linked_set, set, linked_list;
	representation: linked;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_SET [G] inherit

	SET [G];

	LINKED_LIST [G]
		rename
			add as ll_add
		export
			{NONE}
				ll_add
		undefine
			put, empty
		select
			add
		end

creation

	make

feature -- Insertion

	add (v: G) is
			-- Include `v' in `Current'.
		do
			if empty or else not has (v) then
				ll_add (v)
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
				add (other.item);
				other.forth
			end
		end;

feature -- Transformation

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

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is `Current' a subset of `other'?
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

end -- class LINKED_SET
