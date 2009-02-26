class B

feature {NONE} -- Test

	anchor: A [ANY]

	f (a: ANY): BOOLEAN
		do
			Result := True
		end

	g (a: like anchor; b: ANY)
		require
			a1: a + b /= Void
			a2: a.add (b) /= Void
		do
		end

end
