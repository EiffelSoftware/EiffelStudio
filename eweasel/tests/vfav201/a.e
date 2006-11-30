class A

feature -- Function with bracket alias

	b alias "[]" ($(ARGS): BOOLEAN): BOOLEAN is
		do
		end

feature -- Function without alias

	h ($(ARGS): BOOLEAN): BOOLEAN is
		do
		end

end