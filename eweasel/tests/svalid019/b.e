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
			a3: 23 <= {INTEGER_64} 4
			a4: {INTEGER} 64 <= {NATURAL_16} 32
		do
		end

end
