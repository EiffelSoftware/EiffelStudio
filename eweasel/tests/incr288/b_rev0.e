class B [G, H]
inherit
	A [H]
		redefine
			f
		end

feature

	f (x: LINKED_LIST [H]) is
		require else
			x_not_void: x /= Void
			x_twin_not_void: x.twin /= Void
		do
			Precursor (x)
		end

end
