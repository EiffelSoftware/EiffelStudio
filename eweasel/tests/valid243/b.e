class B [G -> {TEST, A [H]}, H]

feature {NONE} -- Test

	f (a: TEST): BOOLEAN
		do
			Result := True
		end

	g (a: A [TEST]; b: TEST)
		require
			f (a + b)
		do
		end

	t (a: H): BOOLEAN
		do
			Result := True
		end

	h (a: G; b: H)
		require
			t (a + b)
		do
		end

end
