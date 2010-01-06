class
	B1

inherit
	A
		rename
			f as f1,
			g as g1
		redefine
			g1
		end

feature

	g1: STRING do Result := "g1%N" end


end
