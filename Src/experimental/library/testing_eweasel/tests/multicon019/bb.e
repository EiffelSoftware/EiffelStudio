class BB

inherit
	B[A]
		redefine
			a, f
		end

feature
	a: AA

	f: ANY
		do
			Result := a.f_of_aa
		end
end
