note

	description:
		"Linkable cells with a reference to the left and right neighbors"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: bi_linkable, cell;
	representation: linked;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class BI_LINKABLE [G] inherit

	LINKABLE [G]
		redefine
			put_right, forget_right
		end

feature -- Access

	left: like Current
			-- Left neighbor

feature {CELL, CHAIN} -- Implementation

	put_right (other: like Current)
			-- Put `other' to the right of current cell.
		do
			if right /= Void then
				right.simple_forget_left
			end
			right := other
			if (other /= Void) then
				other.simple_put_left (Current)
			end
		end

	put_left (other: like Current)
			-- Put `other' to the left of current cell.
		do
			if left /= Void then
				left.simple_forget_right
			end
			left := other
			if (other /= Void) then
				other.simple_put_right (Current)
			end
		ensure
			chained: left = other
		end

	forget_right
			-- Remove links with right neighbor.
		do
			if right /= Void then
				right.simple_forget_left
				right := Void
			end
		ensure then
	 		right_not_chained:
	 			(old right /= Void) implies ((old right).left = Void)
		end

	forget_left
			-- Remove links with left neighbor.
		do
			if left /= Void then
				left.simple_forget_right
				left := Void
			end
		ensure
			left_not_chained:
			left = Void or else
	 			(old left /= Void) implies ((old left).right = Void)
		end

feature {BI_LINKABLE, TWO_WAY_LIST} -- Implementation

	simple_put_right (other: like Current)
			-- set `right' to `other'
		do
			if right /= Void then
				right.simple_forget_left
			end
			right := other
		end

	simple_put_left (other: like Current)
			-- set `left' to `other' is
		do
			if left /= Void then
				left.simple_forget_right
			end
			left := other
		end

	simple_forget_right
			-- Remove right link (do nothing to right neighbor).
		do
			right := Void
		end

	simple_forget_left
			-- Remove left link (do nothing to left neighbor).
		do
			left := Void
		ensure
			not_chained: left = Void
		end

invariant

	right_symmetry:
		(right /= Void) implies (right.left = Current)
	left_symmetry:
		(left /= Void) implies (left.right = Current)

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class BI_LINKABLE



