--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Linkable cells with a reference to the left and right neighbors

indexing

	names: bi_linkable, cell;
	representation: linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BI_LINKABLE [G] inherit

	LINKABLE [G]
		rename
			forget_right as simple_forget_right
		export
			{BI_LINKABLE, TWO_WAY_LIST}
				simple_forget_right
		redefine
			put_right
		end;

	LINKABLE [G]
		redefine
			put_right, forget_right
		select
			forget_right
		end

feature -- Access

	left: like Current;
			-- Left neighbor

feature {CELL, CHAIN} -- Insertion

	put_right (other: like Current) is
			-- Put `other' to the right of `Current'.
		do
			right := other;
			if (other /= Void) and then (other.left /= Current) then
					-- Avoid infinite recursion with put_left !
				other.put_left (Current)
			end
		end;

	put_left (other: like Current) is
			-- Put `other' to the left of `Current'.
		do
			left := other;
			if (other /= Void) and then (other.right /= Current) then
					-- Avoid infinite recursion with put_right !
				other.put_right (Current)
			end
		ensure
			chained: left = other
		end;

feature {CELL, CHAIN} -- Deletion

	forget_right is
			-- Remove links with right neighbor.
		do
			if right /= Void then
				right.simple_forget_left;
				right := Void
			end
		ensure then
	--		not_chained:
	--			(old right /= Void) implies ((old right).left = Void)
		end;

	forget_left is
			-- Remove links with left neighbor.
		do
			if left /= Void then
				left.simple_forget_right;
				left := Void
			end
		ensure
			not_chained:
				left = Void;
	--			(old left /= Void) implies ((old left).right = Void)
		end;

feature {BI_LINKABLE, TWO_WAY_LIST} -- Deletion

	simple_forget_left is
			-- Remove left link (do nothing to left neighbor).
		do
			left := Void
		ensure
			not_chained: left = Void
		end;

invariant

	right_symmetry:
		(right /= Void) implies (right.left = Current);
	left_symmetry:
		(left /= Void) implies (left.right = Current)

end
