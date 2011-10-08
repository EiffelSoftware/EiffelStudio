class
	TEST [G -> A create make end]

create
	make

feature

	make
			-- create object
		do
			create generic
		end

	-- generic: GENERIC[G]
	generic: GENERIC[like a]

	a: G

end
