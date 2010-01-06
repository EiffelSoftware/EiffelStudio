class C

inherit
	A
	B
		redefine
			f$(COUNT)
		end

feature

	f$(COUNT) alias "[]" ($(ARGS): BOOLEAN): BOOLEAN is
		do
		end

end