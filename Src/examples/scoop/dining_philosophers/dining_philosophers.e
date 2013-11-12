note
	description: "Dining philosopers example."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DINING_PHILOSOPHERS

create
	make

feature -- Initialization

	make
			-- Create philosophers and forks
			-- and initiate the dinner.
		local
			first_fork: separate FORK
			left_fork: separate FORK
			right_fork: separate FORK
			philosopher: separate PHILOSOPHER
			i: like philosopher_count
		do
			print ("Dining Philosophers%N" + philosopher_count.out + " philosophers, " + round_count.out + " rounds%N%N")
			create philosophers.make
			from
				i := 1
				create first_fork.make (philosopher_count, 1)
				left_fork := first_fork
			until
				i > philosopher_count
			loop
				if i < philosopher_count then
					create right_fork.make (i, i + 1)
				else
					right_fork := first_fork
				end
				create philosopher.make (i, left_fork, right_fork, round_count)
				philosophers.extend (philosopher)
				left_fork := right_fork
				i := i + 1
			end
			philosophers.do_all (agent launch_philosopher)
		end

feature {NONE} -- Implementation

	philosopher_count: NATURAL = 5
			-- Number of philosophers.

	round_count: NATURAL = 30
			-- Number of times each philosopher should eat.

	philosophers: LINKED_LIST [separate PHILOSOPHER]
			-- List of philosophers.

	launch_philosopher (a_philosopher: separate PHILOSOPHER)
			-- Launch a_philosopher.
		do
			a_philosopher.live
		end

note
	copyright: "Copyright (c) 2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
