class BB

inherit
	B
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
