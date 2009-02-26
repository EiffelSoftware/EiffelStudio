class B

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

end
