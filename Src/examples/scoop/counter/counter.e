note
	description: "Objects that implement counters"
	author: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTER

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initiaization

	make (a_identifier: INTEGER_32; a_speed: INTEGER_64)
			-- Initialize with `a_identifier' and `a_speed'.
		require
			a_counter_number_valid: a_identifier >= 0
			a_speed_valid: a_speed >= 0
		do
			identifier := a_identifier
			speed := a_speed
		ensure
			identifier_set: identifier = a_identifier
			speed_set: speed = a_speed
		end

feature -- Access

	identifier: INTEGER_32
			-- Identifier

	value: INTEGER_32
			-- Value

	speed: INTEGER_64
			-- Speed in nanoseconds

feature -- Basic operations

	run (a_count: INTEGER)
			-- Increment counter `a_count' times.
		do
			across 1 |..| a_count as ic
			loop
				increment
				output
				sleep (speed)
			end
		end

	output
			-- Output the state of counter
		local
			res: STRING_8
		do
			create res.make_empty
			res.append ("Value of counter " + identifier.out + " with speed " + (speed // 1_000_000).out + " ms is: " + value.out + "%N")
			print (res)
			res.wipe_out
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
