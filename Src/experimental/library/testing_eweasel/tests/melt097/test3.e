expanded class
	TEST3

inherit
	ANY
		redefine
			out
		end

feature

	s: detachable STRING

	out: STRING
		do
			Result := "Coucou"
		end

end
