class TEST1 [G]

feature

	make is
		require
			b: create {ARRAY [like {G}.out]}.make_filled (Void, 1, 2) /= Void
		do
		end

end
