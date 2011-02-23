note
	description	: "Objects that implement counters"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	COUNTER

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initiaization

	make (an_identifier: INTEGER_32; a_speed: INTEGER_64)
			-- Creation
		require
			a_counter_number_valid: an_identifier >= 0
			a_speed_valid: a_speed >= 0
		do
			identifier := an_identifier
			speed := a_speed
		ensure
			an_identifier_set: identifier = an_identifier
			a_speed_set: speed = a_speed
		end

feature -- Access

	identifier: INTEGER_32
			-- Identifier of counter

	value: INTEGER_32
			-- Value of counter

	speed: INTEGER_64
			-- Speed of counter in nanoseconds

feature -- Element change

	run (a_count: INTEGER)
			-- Run counter infinitely long.
		local
			i: INTEGER
		do
			from

			until
				i = a_count
			loop
				increment
				output
				sleep (speed)
				i := i + 1
			end
		end

	output
			-- Output the state of counter
		local
			res: STRING_8
		do
			create res.make_empty
			res.append ("Value of counter " + identifier.out + " with speed " + (speed // 1_000_000).out + " ms is: " + value.out + "%N")
			io.put_string (res)
			res.clear_all
		end

	increment
			-- Increment counter
		do
			value := value + 1
		ensure
			value = old value + 1
		end

invariant
	identifier_positive: identifier > 0
	value_positive: value >= 0
	speed_positvie: speed >= 0
end
