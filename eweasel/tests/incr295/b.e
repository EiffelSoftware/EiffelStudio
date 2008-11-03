class
	B [G -> STRING create make_from_string end]

inherit
	A [G]
		rename g as g1
		redefine g1
		select g1
		end

	A [G]
		rename f as f1 -- This should raise a VMCS warning if f is not replicated.
		select f1
		end

create
	make

feature
	make
		do
			f
			f1
		end

feature

	g1: G do create Result.make_from_string ("g1%N") end

end
