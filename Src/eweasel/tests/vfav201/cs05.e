class C

inherit
	A
		redefine
			h
		end

feature

	h alias "[]" ($(ARGS): BOOLEAN): BOOLEAN is
		do
		end

end