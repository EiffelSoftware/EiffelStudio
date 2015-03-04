class
	PRODUCER

create
	make

feature {NONE}

	make (sh: separate SHARED_QUEUE [INTEGER]; max: INTEGER)
		do
			shared := sh
			max_iterations := max
		end

feature
	max_iterations: INTEGER

	shared: separate SHARED_QUEUE [INTEGER]

	live
		local
			i: INTEGER
		do
			from i := 1
			until i > max_iterations
			loop
				run (shared, i)
				i := i + 1
			end
		end

	run (a_shared: separate SHARED_QUEUE [INTEGER]; i: INTEGER)
		do
			a_shared.enqueue (i)
		end

end
