note
	description: "Philosoper that thinks and then eats using two assigned forks when they are not used by anybody."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	PHILOSOPHER

inherit
	REPEATABLE
		rename
			repeat as live
		redefine
			act
		end

create
	make

feature -- Initialization

	make (philosopher: NATURAL; left, right: separate FORK; round_count: NATURAL)
			-- Initialize with ID of `philosopher', forks `left' and `right', and for `round_count' times to eat.
		require
			valid_id: philosopher >= 1
			valid_times_to_eat: round_count >= 1
		do
			id := philosopher
			left_fork := left
			right_fork := right
			times_to_eat := round_count
		ensure
			id_set: id = philosopher
			left_fork_set: left_fork = left
			right_fork_set: right_fork = right
			times_to_eat_set: times_to_eat = round_count
		end

feature -- Access

	id: NATURAL
			-- Philosopher's id.

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := times_to_eat = 0
		end

feature -- Measurement

	times_to_eat: NATURAL
			-- How many times does it remain for the philosopher to eat?

feature -- Basic operations

	act
			-- <Precursor>
		do
			think
			eat (left_fork, right_fork)
		end

	forth
			-- <Precursor>
		do
			times_to_eat := times_to_eat - 1
		end

	eat (left, right: separate FORK)
			-- Eat, having acquired `left' and `right' forks.
		do
				-- Take forks.
			left.pick (Current)
			right.pick (Current)
				-- Eat.
			delay (200)
				-- Put forks back.
			left.put (Current)
			right.put (Current)
		end

	think
			-- Think ... for a short time.
		do
			delay (400)
		end

feature {NONE} -- Access

	left_fork: separate FORK
			-- Left fork used for eating.	

	right_fork: separate FORK
			-- Right fork used for eating.

feature {NONE} -- Timing

	delay (milliseconds: INTEGER_64)
			-- Delay execution by `milliseconds'.
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (milliseconds * 1_000_000)
		end

invariant
	valid_id: id >= 1

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
