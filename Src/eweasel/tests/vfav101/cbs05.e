class C

inherit
	A
		redefine
			bp
		end

feature

	bp alias "and" (x: BOOLEAN): BOOLEAN is
		do
		end

end