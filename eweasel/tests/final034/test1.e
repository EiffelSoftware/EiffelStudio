deferred class TEST1 [G]

feature

	put1 (v: G; i: INTEGER) is
		-- Replace character at position `i' by `v'.
		require
			i > 0
		deferred
		ensure
			True
		end


	put2 (v: G; i: INTEGER) is
		-- Replace character at position `i' by `v'.
		require
			i > 0
		do
		ensure
			True
		end

end
