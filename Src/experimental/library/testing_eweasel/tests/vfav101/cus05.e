class C

inherit
	A
		redefine
			up
		end

feature

	up alias "not": BOOLEAN is
		do
		end

end