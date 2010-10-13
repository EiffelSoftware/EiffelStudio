indexing
	description	: "Objects that implement counters"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	COUNTER

create
	make

feature -- Access

	identifier: INTEGER_32
			-- Identifier of counter

	value: INTEGER_32
			-- Value of counter

	speed: INTEGER_32
			-- Speed of counter

feature -- Element change

	run is
			-- Run counter infinitely long.
		do
			from

			until
				false
			loop
				increment
				output
				-- scoop_sleep (speed)
			end
		end

	run_100 is
			-- Run counter 100 values
		 local
			i: INTEGER_32
		do
			from
				i := 1
			until
				i > 100
			loop
				increment
				i := i + 1
				output
				-- scoop_sleep (speed)
			end
		end

	output is
			-- Output the state of counter
		 local
			res: STRING_8
		do
			create res.make_empty
			res.append ("Value of counter " + identifier.out + " with speed " + speed.out + " ms is: " + value.out + "%N")
			io.put_string (res)
			res.clear_all
		end

	increment is
			-- Increment counter
		 do
			value := value + 1
		ensure
			value = old value + 1
		end

	set_value (a_value: INTEGER_32) is
			-- Set `value' to `a_value'.
		require
			a_value_positive: a_value >= 0
		do
			value := a_value
		ensure
			value_assigned: value = a_value
		end

	set_speed (a_speed: INTEGER_32) is
			-- Set `speed' to `a_speed'.
		require
			a_speed_positvie: a_speed >= 0
		do
			speed := a_speed
		ensure
			speed_assigned: speed = a_speed
		end

feature  -- Implementation

	make (an_identifier: INTEGER_32; a_speed: INTEGER_32) is
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

invariant
	identifier_positive: identifier > 0
	value_positive: value >= 0
	speed_positvie: speed >= 0
end
