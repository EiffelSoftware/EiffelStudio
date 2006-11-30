class C

inherit
	A
	B
		redefine
			f1
		end

feature

	f1 alias "+" (x: BOOLEAN): BOOLEAN is
		do
		end

end