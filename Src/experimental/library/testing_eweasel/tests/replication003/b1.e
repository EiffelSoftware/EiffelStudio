class
	B1

inherit
	A
		rename
			f as f1,
			g as g1
		redefine
			f1,
			g1
		end

feature

	f1
		do
			precursor {A}
			print (g1)
		end

	g1: STRING do Result := "g1%N" end


end
