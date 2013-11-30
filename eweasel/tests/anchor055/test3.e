class TEST3

inherit
	ANY
		redefine
			out
		end

feature

	out: STRING
		do
			Result := "OK"
		end

end
