indexing

	description:
		"Linkable cells with a reference to the left and right neighbors";

	status: "See notice at end of class";
	names: bi_linkable, cell;
	representation: linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BI_LINKABLE [G] inherit

	LINKABLE [G]
		redefine
			put_right, forget_right
		end

feature -- Access

	left: like Current;
			-- Left neighbor

feature {CELL, CHAIN} -- Implementation

	put_right (other: like Current) is
			-- Put `other' to the right of current cell.
		do
			if right /= Void then
				right.simple_forget_left
			end;
			right := other;
			if (other /= Void) then
				other.simple_put_left (Current)
			end
		end;

	put_left (other: like Current) is
			-- Put `other' to the left of current cell.
		do
			if left /= Void then
				left.simple_forget_right
			end;
			left := other;
			if (other /= Void) then
				other.simple_put_right (Current)
			end
		ensure
			chained: left = other
		end;

	forget_right is
			-- Remove links with right neighbor.
		do
			if right /= Void then
				right.simple_forget_left;
				right := Void
			end
		ensure then
	 		right_not_chained:
	 			(old right /= Void) implies ((old right).left = Void)
		end;

	forget_left is
			-- Remove links with left neighbor.
		do
			if left /= Void then
				left.simple_forget_right;
				left := Void
			end
		ensure
			left_not_chained:
				left = Void;
	 			(old left /= Void) implies ((old left).right = Void)
		end;

feature {BI_LINKABLE, TWO_WAY_LIST} -- Implementation

	simple_put_right (other: like Current) is
			-- set `right' to `other'
		do
			if right /= Void then
				right.simple_forget_left;
			end;
			right := other
		end;

	simple_put_left (other: like Current) is
			-- set `left' to `other' is
		do
			if left /= Void then
				left.simple_forget_right
			end;
			left := other
		end;

	simple_forget_right is
			-- Remove right link (do nothing to right neighbor).
		do
			right := Void
		end;

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

end -- class BI_LINKABLE


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
