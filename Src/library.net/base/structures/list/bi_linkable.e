indexing
	description: "Linkable cells with a reference to the left and right neighbors"
	external_name: "ISE.Base.BiLinkable"

class 
	BI_LINKABLE [G] 

inherit
	LINKABLE [G]
		redefine
			put_right, forget_right, right
		end

feature -- Access

	right: BI_LINKABLE [G]
		indexing
			description: "Right neighbor"
		end

	left: BI_LINKABLE [G]
		indexing
			description: "Left neighbor"
		end

feature {CELL, CHAIN} -- Implementation

	put_right (other: BI_LINKABLE [G]) is
		indexing
			description: "Put `other' to the right of current cell."
		do
			if right /= Void then
				right.simple_forget_left
			end
			right := other
			if (other /= Void) then
				other.simple_put_left (Current)
			end
		end

	put_left (other: BI_LINKABLE [G]) is
		indexing
			description: "Put `other' to the left of current cell."
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

	forget_right is
		indexing
			description: "Remove links with right neighbor."
		do
			if right /= Void then
				right.simple_forget_left
				right := Void
			end
		ensure then
	 		right_not_chained:
	 			(old right /= Void) implies ((old right).left = Void)
		end

	forget_left is
		indexing
			description: "Remove links with left neighbor."
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

	simple_put_right (other: BI_LINKABLE [G]) is
		indexing
			description: "Set `right' to `other'."
		do
			if right /= Void then
				right.simple_forget_left
			end
			right := other
		end

	simple_put_left (other: BI_LINKABLE [G]) is
		indexing
			description: "Set `left' to `other'."
		do
			if left /= Void then
				left.simple_forget_right
			end
			left := other
		end

	simple_forget_right is
		indexing
			description: "Remove right link (do nothing to right neighbor)."
		do
			right := Void
		end

	simple_forget_left is
		indexing
			description: "Remove left link (do nothing to left neighbor)."
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

end -- class BI_LINKABLE



