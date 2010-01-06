expanded class TEST1 [G]

feature

	tilde_compare (u, v: G): BOOLEAN is
		do
			Result := u ~ v
		end

	not_tilde_compare (u, v: G): BOOLEAN is
		do
			Result := u /~ v
		end

end
