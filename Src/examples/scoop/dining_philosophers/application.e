indexing
	description	: "System's root class"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	reviewer	: "Benjamin Morandi"
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			i: INTEGER
			a_first_fork: separate FORK
			a_left_fork: separate FORK
			a_right_fork: separate FORK
			a_philosopher: separate PHILOSOPHER
		do
			io.put_string ("Dining Philosophers%N" + number_of_philosophers.out + " philosophers, " + number_of_rounds.out + " rounds%N%N")
			from
				create a_first_fork
				i := 1
				a_left_fork := a_first_fork
			until
				i > number_of_philosophers
			loop
				if i <= number_of_philosophers then
					create a_right_fork
				else
					a_right_fork := a_first_fork
				end
				create a_philosopher.make (i, a_left_fork, a_right_fork, number_of_rounds)
				launch_philosopher (a_philosopher)
				i := i + 1
				a_left_fork := a_right_fork
			end
			io.put_string ("Make Done!!%N")
		end

feature {NONE} -- Implementation

	number_of_philosophers: INTEGER = 5

	number_of_rounds: INTEGER = 30

	launch_philosopher (a_philosopher: separate PHILOSOPHER)
			-- Launch a_philosopher.
		do
			a_philosopher.live
		end

end -- class APPLICATION
