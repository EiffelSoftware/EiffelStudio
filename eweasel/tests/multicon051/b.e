class B [G -> {A [ANY], C}]

feature {NONE} -- Test

	anchor: G

	f (a: ANY): BOOLEAN
		do
			Result := True
		end

	g (a: like anchor; b: ANY)
		require
			a1: a + b /= Void
			a2: -a /= Void
			a3: (-a) + (b) /= Void
			a4: (-a).add (b) /= Void
			a5: a.add (b) /= Void
			a6: a.minus /= Void
		do
		end

end
