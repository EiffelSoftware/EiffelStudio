class B [G -> {E, A [E]}]

feature -- Test

	g (a: A [E])
		require
			t (+ a)
		do
		end

	t (a: ANY): BOOLEAN
		do
			Result := True
		end

	h (a: G)
		require
			t (+ a)
		do
		end

end
