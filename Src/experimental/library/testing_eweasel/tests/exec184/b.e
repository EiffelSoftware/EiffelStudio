class B [G]

inherit

	A [G]
		redefine
			s
		end

feature -- Access

	s: STRING is
			-- Result is a once manifest string
		do
			Result := Precursor
		end

end