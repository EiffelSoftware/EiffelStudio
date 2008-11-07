class
	B2

inherit
	A
		rename
			g as g2
		redefine
			g2
		end

feature

	g2: STRING do Result := "g2%N" end

end
