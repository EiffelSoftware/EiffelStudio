class DD

inherit

	CC [INTEGER]
		redefine
			f
		end

feature

	f: ARRAY [INTEGER] is
		do
			Result := precursor
		end

end
