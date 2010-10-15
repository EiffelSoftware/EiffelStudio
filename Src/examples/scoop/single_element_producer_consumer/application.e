indexing
	description : "scoop_test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

--inherit
--	ARGUMENTS

create
	make

feature {NONE} -- Initialization
	prod : separate PRODUCER
	cons : separate CONSUMER

	make
		do
			create prod.make
			create cons.make (prod)
			run (cons)
		end

	run (c : separate CONSUMER)
		do
			c.run

			from until False loop
				produce (prod)
			end
		end

	produce (p : separate PRODUCER)
		require
			not p.has_something
		do
			p.make_something
		end
end
