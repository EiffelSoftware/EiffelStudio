class
	B2

inherit
	A
		rename
			f as f2,
			g as g2
		redefine
			f2,
			g2
		end

feature

	f2
		do
			precursor {A}
			print (g2)
		end

	g2: STRING do Result := "g2%N" end


end
