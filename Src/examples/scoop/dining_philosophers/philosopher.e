note
	description: "Objects that implement philosophers."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	reviewer	: "Benjamin Morandi"
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"
class
	PHILOSOPHER

inherit
	PROCESS

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_left_fork, a_right_fork: separate FORK; a_number_of_rounds: INTEGER)
			-- Creation procedure.
		require
			forks_exist: a_left_fork /= void and then a_right_fork /= void
		do
			id := an_id
			left_fork := a_left_fork
			right_fork := a_right_fork
			number_of_rounds := a_number_of_rounds
		end

feature

	step
			-- Perform a philosopher'’stasks.
		do
			think
			eat (left_fork, right_fork)
		end

	eat (l, r: separate FORK)
			-- Eat, having grabbed l and r.
		do
			io.put_string ("Philosopher " + id.out + ": taking forks%N")
			-- scoop_sleep (400)
			times_eaten := times_eaten + 1
			io.put_string ("Philosopher " + id.out + ": eating%N")
			io.put_string ("Philosopher " + id.out + ": putting forks back%N")
		end

	think
			-- Think.
		do
			io.put_string ("Philosopher " + id.out + ": thinking%N")
		end

	over: BOOLEAN
			-- Is execution over?
		do
			Result := times_eaten >= number_of_rounds
		end

feature {NONE} -- Implementation

	id: INTEGER
			-- Philosopher's id.

	number_of_rounds: INTEGER
			-- Number of times philosopher should eat.

	times_eaten: INTEGER
			-- Number of times philosopher has eaten so far.

	left_fork: separate FORK
			-- Left fork used for eating.	

	right_fork: separate FORK
			-- Right fork used for eating.

invariant
	left_fork /= void
	right_fork /= void
	times_eaten <= number_of_rounds

end -- class PHILOSOPHER
