class C

inherit
	B
		redefine
			f2
		end

feature

	f2 alias "[]" convert (x, y: BOOLEAN): BOOLEAN is
		do
		end

end