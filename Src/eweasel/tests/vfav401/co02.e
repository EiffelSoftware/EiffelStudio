class C

inherit
	B
		redefine
			f1
		end

feature

	f1 alias "$(OPERATOR)" (x: BOOLEAN): BOOLEAN is
		do
		end

end